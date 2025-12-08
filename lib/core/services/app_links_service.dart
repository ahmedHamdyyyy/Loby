import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Simple deep-link handler using the `app_links` plugin.
///
/// Contract:
/// - Accepts custom schemes (e.g., loby://app/open/reservation/123)
/// - Parses into a simple map compatible with existing notification navigation handlers
/// - Calls [onRouteData] on the UI thread when a supported link is received
class AppLinksService {
  AppLinksService({
    required this.navigatorKey,
    required this.onRouteData,
    this.acceptedSchemes = const ['loby'],
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(Map<String, dynamic> data) onRouteData;
  final List<String> acceptedSchemes;

  AppLinks? _appLinks;
  StreamSubscription<Uri>? _sub;

  Future<void> init() async {
    try {
      _appLinks = AppLinks();

      // Handle an initial link if available
      try {
        final initial = await _appLinks!.getInitialLink();
        if (initial != null) {
          _handleUri(initial);
        }
      } catch (_) {}

      // Listen for link changes while app is running
      _sub = _appLinks!.uriLinkStream.listen(_handleUri, onError: (e, st) {
        if (kDebugMode) {
          // ignore: avoid_print
          print('AppLinks error: $e');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Failed to initialize AppLinks: $e');
      }
    }
  }

  void dispose() {
    _sub?.cancel();
  }

  void _handleUri(Uri uri) {
    try {
      if (!acceptedSchemes.contains(uri.scheme)) return;
      // Expect host 'app' and paths like /open/<type>/<id>
      final segments = uri.pathSegments;
      if (segments.length < 3) return;
      if (segments[0] != 'open') return;
      final type = segments[1];
      final id = segments[2];

      Map<String, dynamic> data;
      switch (type) {
        case 'reservation':
          data = {'type': 'new_registration', 'registrationId': id};
          break;
        case 'activity':
          data = {'type': 'new_activity', 'activityId': id};
          break;
        case 'property':
          data = {'type': 'new_property', 'propertyId': id};
          break;
        default:
          return;
      }

      // Ensure we run on the UI thread and only when Navigator is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigatorKey.currentState != null) {
          onRouteData(data);
        } else {
          // Try once more shortly if the navigator isn't ready yet
          Future.delayed(const Duration(milliseconds: 200), () {
            if (navigatorKey.currentState != null) onRouteData(data);
          });
        }
      });
    } catch (_) {
      // swallow
    }
  }
}
