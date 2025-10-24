import 'dart:convert';
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/constants/api_constance.dart';
import 'config/constants/constance.dart';
import 'core/localization/localization_cubit.dart';
import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'locator.dart';
import 'project/activities/logic/cubit.dart';
import 'project/activities/view/screens/activity_screen.dart';
import 'project/auth/logic/auth_cubit.dart';
import 'project/home/view/luby_screen_splash.dart';
import 'project/notifications/logic/cubit.dart';
import 'project/profile/logic/cubit.dart';
import 'project/properties/logic/cubit.dart';
import 'project/properties/view/property_screen.dart';
import 'project/reservation/logic/cubit.dart';
import 'project/reservation/view/reservation_details_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}
  developer.log('BG message: ${message.messageId}', name: 'FCM');

  // Setup local notifications in bg isolate
  const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
  const iosInit = DarwinInitializationSettings();
  const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);
  final android =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await android?.createNotificationChannel(_defaultAndroidChannel);

  final title = message.notification?.title ?? message.data['title']?.toString();
  final body = message.notification?.body ?? message.data['body']?.toString();
  if (title != null || body != null) {
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _defaultAndroidChannel.id,
          _defaultAndroidChannel.name,
          channelDescription: _defaultAndroidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      // Pass JSON payload so we can parse it on tap
      payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
    );
  }
}

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _defaultAndroidChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'Used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

Future<void> _initLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
  const iosInit = DarwinInitializationSettings();
  final initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
  await _flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (response) {
      final payload = response.payload;
      if (payload == null || payload.isEmpty) return;
      try {
        final data = Map<String, dynamic>.from(jsonDecode(payload));
        _handleNotificationNavigation(data);
      } catch (e) {
        developer.log('Failed to parse notification payload: $e', name: 'FCM');
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  final android =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await android?.createNotificationChannel(_defaultAndroidChannel);
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  try {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    final data = Map<String, dynamic>.from(jsonDecode(payload));
    // We can't navigate here (background isolate), store for initial handling on app resume if needed.
    // For simplicity, rely on onMessageOpenedApp for FCM and foreground onTap for local notifications.
    developer.log('Background notification tap payload: $data', name: 'FCM');
  } catch (e) {
    developer.log('Error in background notification tap: $e', name: 'FCM');
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

void _handleNotificationNavigation(Map<String, dynamic> data) {
  // Expected data includes: type (snake_case), and one of: activityId, propertyId, registrationId
  final type = (data['type'] ?? data['notificationType'] ?? '').toString();
  String? entityId = data['registrationId']?.toString();
  if (entityId == null || entityId.isEmpty) {
    entityId = data['activityId']?.toString();
  }
  if (entityId == null || entityId.isEmpty) {
    entityId = data['propertyId']?.toString();
  }
  if (entityId == null || entityId.isEmpty) {
    developer.log('No entityId found in notification data: $data', name: 'FCM');
    return;
  }

  final nav = _rootNavigatorKey.currentState;
  if (nav == null) return;

  // Normalize type variations to lower_snake
  final t = type.toLowerCase();
  if (t.contains('new_registration') || t.contains('confirm_payment') || t.contains('refund')) {
    nav.push(MaterialPageRoute(builder: (_) => ReservationDetailsScreen(reservationId: entityId!)));
    return;
  }
  if (t.contains('new_activity') || t.contains('activity_verification')) {
    nav.push(MaterialPageRoute(builder: (_) => ActivityScreen(activityId: entityId!)));
    return;
  }
  if (t.contains('new_property') || t.contains('property_verification')) {
    nav.push(MaterialPageRoute(builder: (_) => PropertyScreen(propertyId: entityId!)));
    return;
  }
  developer.log('Unhandled notification type: $type', name: 'FCM');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Local notifications + permissions
  await _initLocalNotifications();
  final androidLn =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await androidLn?.requestNotificationsPermission();

  // Request permission (iOS/macOS + Android 13+ behavior)
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(alert: true, badge: true, sound: true);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  // Get and log FCM token
  final fcmToken = await messaging.getToken();
  developer.log('FCM Token: $fcmToken', name: 'FCM');
  // ignore: avoid_print
  print('FCM Token: $fcmToken');

  FirebaseMessaging.instance.onTokenRefresh.listen((t) async {
    developer.log('FCM Token refreshed: $t', name: 'FCM');
    await _updateFcmTokenIfLoggedIn(t);
  });

  // Foreground messages
  FirebaseMessaging.onMessage.listen((message) async {
    final notification = message.notification;
    final android = notification?.android;
    developer.log('FG message: ${message.messageId}', name: 'FCM');
    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _defaultAndroidChannel.id,
            _defaultAndroidChannel.name,
            channelDescription: _defaultAndroidChannel.description,
            icon: android?.smallIcon ?? '@mipmap/launcher_icon',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
      );
    }
    // Also navigate immediately when app is in foreground if entityId exists
    if (message.data.isNotEmpty) {
      _handleNotificationNavigation(message.data);
    }
  });

  // Notification tapped while app in background
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    developer.log('Notification clicked. Data: ${message.data}', name: 'FCM');
    if (message.data.isNotEmpty) _handleNotificationNavigation(message.data);
  });

  // App launched from terminated by tapping notification
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    developer.log('Opened from terminated via notification: ${initialMessage.data}', name: 'FCM');
    if (initialMessage.data.isNotEmpty) {
      // Delay navigation until after runApp
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleNotificationNavigation(initialMessage.data));
    }
  }
  setup();
  await getIt<CacheService>().init();
  await getIt<ApiService>().init();
  if (fcmToken != null && fcmToken.isNotEmpty) {
    await _updateFcmTokenIfLoggedIn(fcmToken);
  }
  runApp(const MyApp());
}

Future<void> _updateFcmTokenIfLoggedIn(String token) async {
  try {
    final accessToken = getIt<CacheService>().storage.getString(AppConst.accessToken);
    if (accessToken == null || accessToken.isEmpty) return;
    await getIt<ApiService>().dio.post(ApiConstance.updateFcmToken, data: {'fcmToken': token});
  } catch (e) {
    developer.log('Failed to update FCM token: $e', name: 'FCM');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<AuthCubit>()),
      BlocProvider(create: (context) => getIt<ProfileCubit>()),
      BlocProvider(create: (context) => getIt<ActivitiesCubit>()),
      BlocProvider(create: (context) => getIt<PropertiesCubit>()),
      BlocProvider(create: (context) => getIt<ReservationsCubit>()),
      BlocProvider(create: (context) => getIt<NotificationsCubit>()),
      BlocProvider(create: (context) => getIt<LocalizationCubit>()..loadSaved()),
    ],
    child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LocalizationCubit, Locale?>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
              navigatorKey: _rootNavigatorKey,
              home: const LubyScreenSplash(),
              onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'Luby',
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              localeResolutionCallback: (deviceLocale, supported) {
                if (locale != null) return locale;
                if (deviceLocale == null) return supported.first;
                for (final l in supported) {
                  if (l.languageCode == deviceLocale.languageCode) return l;
                }
                return supported.first;
              },
            );
          },
        );
      },
    ),
  );
}
