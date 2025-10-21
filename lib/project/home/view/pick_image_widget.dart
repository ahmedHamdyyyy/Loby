import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/localization/l10n_ext.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.onImagesUploaded});
  final void Function(List<String>) onImagesUploaded;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerWidget> {
  final List<String> _imagePaths = [];

  Future<void> _pickImage() async {
    try {
      final file = await FilePickerWidget.pickImage(context);
      if (file == null) return;
      setState(() => _imagePaths.add(file.path));
      widget.onImagesUploaded(_imagePaths);
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.errorPickingImage)));
      }
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ..._imagePaths.map((imagePath) => _buildImageThumbnail(imagePath)),
              if (_imagePaths.length < 5) _buildAddButton(),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildImageThumbnail(String imagePath) => Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(width: 80, height: 80, child: Image.file(File(imagePath), fit: BoxFit.cover)),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => setState(() => _imagePaths.remove(imagePath)),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildAddButton() => GestureDetector(
    onTap: _pickImage,
    child: Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: const Center(child: Icon(Icons.add, color: Colors.grey, size: 30)),
    ),
  );
}

class FilePickerWidget {
  static final ImagePicker _picker = ImagePicker();

  static Future<bool> _requestImagePermissions(BuildContext context) async {
    try {
      if (await Permission.photos.status.isDenied) {
        final photos = await Permission.photos.request();
        if (photos.isDenied && context.mounted) {
          _showPermissionDialog(context, 'معرض الصور', 'للوصول إلى الصور');
          return false;
        }
      }
      return true;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  static void _showPermissionDialog(BuildContext context, String permissionName, String purpose) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.l10n.permissionRequiredTitle(permissionName)),
            content: Text(context.l10n.permissionRequiredBody(permissionName, purpose)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(context.l10n.commonCancel)),
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child: Text(context.l10n.commonOpenSettings),
              ),
            ],
          ),
    );
  }

  static Future<File?> pickImage(BuildContext context, {ImageSource source = ImageSource.gallery}) async {
    try {
      // final hasPermission = await _requestImagePermissions(context);
      // if (!hasPermission) return null;

      final image = await _picker.pickImage(source: source, imageQuality: 80);

      if (image != null) {
        final fileSize = await File(image.path).length();
        if (fileSize > 5 * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.imageSizeTooLarge(5))));
          }
          return null;
        }
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.errorPickingImage)));
      }
      return null;
    }
  }

  static Future<List<File>> pickMultipleImages(BuildContext context) async {
    try {
      final hasPermission = await _requestImagePermissions(context);
      if (!hasPermission) return [];

      final List<XFile> images = await _picker.pickMultiImage(imageQuality: 80);

      List<File> validImages = [];
      for (var image in images) {
        final fileSize = await File(image.path).length();
        if (fileSize <= 5 * 1024 * 1024) {
          validImages.add(File(image.path));
        }
      }

      if (validImages.length != images.length && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.someImagesIgnoredOver(5))));
      }

      return validImages;
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.errorPickingImages)));
      }
      return [];
    }
  }

  static Future<File?> pickPdfFile(BuildContext context) async {
    try {
      const XTypeGroup typeGroup = XTypeGroup(label: 'PDF Files', extensions: ['pdf']);

      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file != null) {
        final fileSize = await File(file.path).length();
        if (fileSize > 10 * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.fileTooLarge(10))));
          }
          return null;
        }
        return File(file.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking PDF file: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.errorPickingFile)));
      }
      return null;
    }
  }

  static Future<File?> pickVideo(
    BuildContext context, {
    ImageSource source = ImageSource.gallery,
    int maxSizeMB = 15,
  }) async {
    try {
      final video = await _picker.pickVideo(source: source, maxDuration: const Duration(minutes: 10));
      if (video != null) {
        final file = File(video.path);
        final ext = video.path.split('.').last.toLowerCase();
        if (ext != 'mp4') {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.onlyMp4Allowed)));
          }
          return null;
        }
        final fileSize = await file.length();
        if (fileSize > maxSizeMB * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.videoTooLarge(maxSizeMB))));
          }
          return null;
        }
        return file;
      }
      return null;
    } catch (e) {
      debugPrint('Error picking video: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.errorPickingVideo)));
      }
      return null;
    }
  }
}
