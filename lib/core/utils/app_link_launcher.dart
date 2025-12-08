import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> _launchUri(Uri uri) async {
  try {
    if (!await canLaunchUrl(uri)) return false;
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Failed to launch $uri: $e');
    }
    return false;
  }
}

// Open a specific screen in the consumer app (lubyUser)
Future<bool> openUserReservation(String id) => _launchUri(Uri(scheme: 'lubyuser', host: 'app', pathSegments: ['open', 'reservation', id]));
Future<bool> openUserActivity(String id) => _launchUri(Uri(scheme: 'lubyuser', host: 'app', pathSegments: ['open', 'activity', id]));
Future<bool> openUserProperty(String id) => _launchUri(Uri(scheme: 'lubyuser', host: 'app', pathSegments: ['open', 'property', id]));
