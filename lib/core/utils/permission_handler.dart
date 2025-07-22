// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestStoragePermission(BuildContext context) async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      _showPermissionDeniedDialog(context, 'Storage');
      return false;
    }
  }

  static Future<bool> requestCameraPermission(BuildContext context) async {
    if (await Permission.camera.isGranted) {
      return true;
    }

    final status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    } else {
      _showPermissionDeniedDialog(context, 'Camera');
      return false;
    }
  }

  static Future<bool> requestLocationPermission(BuildContext context) async {
    if (await Permission.location.isGranted) {
      return true;
    }

    final status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else {
      _showPermissionDeniedDialog(context, 'Location');
      return false;
    }
  }

  static Future<bool> requestMediaPermissions(BuildContext context) async {
    // For Android 13 and above
    if (await Permission.photos.isGranted && await Permission.videos.isGranted && await Permission.audio.isGranted) {
      return true;
    }

    final photos = await Permission.photos.request();
    final videos = await Permission.videos.request();
    final audio = await Permission.audio.request();

    if (photos.isGranted && videos.isGranted && audio.isGranted) {
      return true;
    } else {
      _showPermissionDeniedDialog(context, 'Media');
      return false;
    }
  }

  static void _showPermissionDeniedDialog(BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('$permissionName Permission Required'),
            content: Text(
              'This app needs $permissionName permission to function properly. '
              'Please grant the permission in app settings.',
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
    );
  }
}
