// Document uploader component
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../home/view/pick_image_widget.dart';

class DocumentUploader extends StatefulWidget {
  const DocumentUploader({super.key, required this.label, required this.paths, required this.onPathesChanged});
  final Function(List<String>) onPathesChanged;
  final List<String> paths;
  final String label;
  @override
  State<DocumentUploader> createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  final List<String> _paths = [];
  @override
  void initState() {
    _paths.addAll(widget.paths);
    super.initState();
  }

  Future<void> _pickFile() async {
    try {
      final file = await FilePickerWidget.pickPdfFile(context);
      if (file == null) return;
      setState(() => _paths.add(file.path));
      widget.onPathesChanged(_paths);
    } catch (e) {
      debugPrint('Error picking PDF file: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الملف')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_paths.isNotEmpty) {
      return Container(
        height: 103,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._paths.map((path) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Image.asset(ImageAssets.pdfIcon, width: 70, height: 75)],
                            ),
                          ),
                          Positioned(
                            top: -0,
                            right: -5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _paths.remove(path));
                                widget.onPathesChanged(_paths);
                              },
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
                  }),
                  if (_paths.length < 10)
                    GestureDetector(
                      onTap: _pickFile,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
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
    } else {
      return Container(
        height: 103,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: _pickFile, child: SvgPicture.asset(ImageAssets.uploadIcon, width: 40, height: 40)),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
