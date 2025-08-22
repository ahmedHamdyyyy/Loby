// Property image upload section
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../home/view/pick_image_widget.dart';

class PropertyImagesSection extends StatefulWidget {
  const PropertyImagesSection({super.key, required this.imagePaths, required this.onImagesChanged});
  final Function(List<String>) onImagesChanged;
  final List<String> imagePaths;
  @override
  State<PropertyImagesSection> createState() => _PropertyImagesSectionState();
}

class _PropertyImagesSectionState extends State<PropertyImagesSection> {
  final List<String> _imagePaths = [];
  @override
  void initState() {
    _imagePaths.addAll(widget.imagePaths);
    super.initState();
  }

  Future<void> _pickImage() async {
    try {
      final file = await FilePickerWidget.pickImage(context);
      if (file == null) return;
      setState(() => _imagePaths.add(file.path));
      widget.onImagesChanged(_imagePaths);
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الصورة')));
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 103,
    width: double.infinity,
    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_imagePaths.isEmpty)
          InkWell(
            onTap: _pickImage,
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(ImageAssets.uploadIcon, width: 40, height: 40),
                  const SizedBox(height: 8),
                  Text(
                    "Upload photos with high quality",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
                  ),
                ],
              ),
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._imagePaths.map(
                  (imagePath) => ImageThumbnail(
                    imagePath: imagePath,
                    onRemove: () {
                      setState(() => _imagePaths.remove(imagePath));
                      widget.onImagesChanged(_imagePaths);
                    },
                  ),
                ),
                if (_imagePaths.length < 10)
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 71,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBCBCB)),
                      ),
                      child: const Center(child: Icon(Icons.add, color: Color(0xFFCBCBCB), size: 30)),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// Thumbnail for an individual image
class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({super.key, required this.imagePath, required this.onRemove});
  final VoidCallback onRemove;
  final String imagePath;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              imagePath.startsWith('http')
                  ? Image.network(
                    imagePath,
                    width: 80,
                    height: 71,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 80,
                        height: 71,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading image: $error');
                      return Container(
                        width: 80,
                        height: 71,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error_outline, color: Colors.red),
                      );
                    },
                  )
                  : Image.file(
                    File(imagePath),
                    width: 80,
                    height: 71,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading local image: $error');
                      return Container(
                        width: 80,
                        height: 71,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error_outline, color: Colors.red),
                      );
                    },
                  ),
        ),
        Positioned(
          top: -8,
          right: -2,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(color: Color(0XFFCC0000), shape: BoxShape.circle),
              child: const Center(child: Icon(Icons.close, size: 15, color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
}
