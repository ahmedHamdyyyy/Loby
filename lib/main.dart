import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'locator.dart';
import 'project/vendor/Home/cubit/home_cubit.dart';
import 'project/vendor/Home/screen/UI/splash/luby_screen_splash.dart';
import 'project/vendor/activities/cubit/cubit.dart';
import 'project/vendor/auth/cubit/auth_cubit.dart';
import 'project/vendor/properties/cubit/cubit.dart';
import 'project/vendor/user/cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  await getIt<CacheService>().init();
  await getIt<ApiService>().init();  
 // await getIt<CacheService>().storage.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<AuthCubit>()),
      BlocProvider(create: (context) => getIt<HomeCubit>()),
      BlocProvider(create: (context) => getIt<UserCubit>()),
      BlocProvider(create: (context) => getIt<ActivitiesCubit>()),
      BlocProvider(create: (context) => getIt<PropertiesCubit>()),
    ],
    child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: const LubyScreenSplash(),
        );
      },
    ),
  );



}
