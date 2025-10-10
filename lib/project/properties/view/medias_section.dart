// Property image upload section
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../home/view/pick_image_widget.dart';

class MediasSection extends StatefulWidget {
  const MediasSection({super.key, required this.medias, required this.onMediasChanged});
  final Function(List<String>) onMediasChanged;
  final List<String> medias; // existing media paths (image/video)
  @override
  State<MediasSection> createState() => _MediasSectionState();
}

class _MediasSectionState extends State<MediasSection> {
  final List<String> _medias = []; // first must always be image
  static const int maxMedias = 5;
  static const int maxImageSizeMB = 5;
  static const int maxVideoSizeMB = 15;

  @override
  void initState() {
    _medias.addAll(widget.medias);
    if (_medias.isNotEmpty && !_isImage(_medias.first)) {
      final idx = _medias.indexWhere((p) => _isImage(p));
      if (idx > 0) {
        final img = _medias.removeAt(idx);
        _medias.insert(0, img);
      }
    }
    super.initState();
  }

  bool _isImage(String path) {
    final l = path.toLowerCase();
    return l.endsWith('.png') ||
        l.endsWith('.jpg') ||
        l.endsWith('.jpeg') ||
        l.endsWith('.gif') ||
        l.endsWith('.webp') ||
        l.endsWith('.bmp');
  }

  Future<void> _showPickTypeSheet() async {
    if (_medias.length >= maxMedias) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('الحد الأقصى للوسائط هو $maxMedias')));
      return;
    }
    await showModalBottomSheet(
      context: context,
      builder:
          (ctx) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('صورة'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('فيديو'),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickVideo();
                  },
                ),
                ListTile(leading: const Icon(Icons.close), title: const Text('إلغاء'), onTap: () => Navigator.pop(ctx)),
              ],
            ),
          ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final file = await FilePickerWidget.pickImage(context);
      if (file == null) return;
      final size = await file.length();
      if (size > maxImageSizeMB * 1024 * 1024) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('حجم الصورة كبير جداً. يجب أن يكون أقل من $maxImageSizeMB ميجابايت')));
        }
        return;
      }
      setState(() => _medias.add(file.path));
      widget.onMediasChanged(_medias);
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الصورة')));
    }
  }

  Future<void> _pickVideo() async {
    if (_medias.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب اختيار صورة أولاً قبل إضافة فيديو')));
      return;
    }
    try {
      final file = await FilePickerWidget.pickVideo(context, maxSizeMB: maxVideoSizeMB);
      if (file == null) return;
      final ext = file.path.split('.').last.toLowerCase();
      if (ext != 'mp4') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يُسمح فقط برفع فيديو MP4')));
        return;
      }
      setState(() => _medias.add(file.path));
      widget.onMediasChanged(_medias);
    } catch (e) {
      debugPrint('Error picking video: $e');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الفيديو')));
    }
  }

  void _onRemove(String path) {
    if (_medias.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب أن تبقى صورة واحدة على الأقل')));
      return;
    }
    final isFirst = _medias.first == path;
    if (isFirst) {
      // find another image to promote
      final idx = _medias.indexWhere((p) => p != path && _isImage(p));
      if (idx == -1) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('لا يمكن إزالة الصورة الأولى لأنها الوحيدة')));
        return;
      }
      setState(() {
        _medias.removeAt(0);
        final img = _medias.removeAt(idx - 1); // list shrank
        _medias.insert(0, img);
      });
    } else {
      setState(() => _medias.remove(path));
    }
    widget.onMediasChanged(_medias);
  }

  void _openPreview(String path) {
    final isImage = _isImage(path);
    showDialog(context: context, builder: (_) => _MediaPreviewDialog(path: path, isImage: isImage));
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 140,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_medias.isEmpty)
          InkWell(
            onTap: _pickImage, // first must be image
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(ImageAssets.uploadIcon, width: 40, height: 40),
                  const SizedBox(height: 8),
                  Text(
                    "Upload at least one image (max $maxMedias medias)",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._medias.map(
                    (p) => MediaThumbnail(
                      path: p,
                      isImage: _isImage(p),
                      onRemove: () => _onRemove(p),
                      onTap: () => _openPreview(p),
                    ),
                  ),
                  if (_medias.length < maxMedias)
                    GestureDetector(
                      onTap: _showPickTypeSheet,
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(right: 10),
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
          ),
      ],
    ),
  );
}

// Thumbnail for an individual image
class MediaThumbnail extends StatefulWidget {
  const MediaThumbnail({super.key, required this.path, required this.onRemove, required this.onTap, required this.isImage});
  final String path;
  final bool isImage;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  @override
  State<MediaThumbnail> createState() => _MediaThumbnailState();
}

class _MediaThumbnailState extends State<MediaThumbnail> {
  VideoPlayerController? _videoController;
  bool _videoInitialized = false;
  bool _videoError = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isImage) {
      try {
        if (widget.path.startsWith('http')) {
          _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.path));
        } else {
          _videoController = VideoPlayerController.file(File(widget.path));
        }
        _videoController!
            .initialize()
            .then((_) {
              if (!mounted) return;
              _videoController!.setVolume(0);
              _videoController!.pause();
              setState(() => _videoInitialized = true);
            })
            .catchError((_) {
              if (mounted) setState(() => _videoError = true);
            });
      } catch (_) {
        _videoError = true;
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget thumb;
    if (widget.isImage) {
      thumb =
          widget.path.startsWith('http')
              ? Image.network(
                widget.path,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _loadingBox();
                },
                errorBuilder: (context, error, stackTrace) => _errorBox(),
              )
              : Image.file(
                File(widget.path),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _errorBox(),
              );
    } else {
      if (_videoError) {
        thumb = _errorBox();
      } else if (!_videoInitialized) {
        thumb = _loadingBox();
      } else {
        // Show first frame using VideoPlayer (paused)
        thumb = Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 80,
                height: 80,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController!.value.size.width,
                    height: _videoController!.value.size.height,
                    child: VideoPlayer(_videoController!),
                  ),
                ),
              ),
            ),
            const Positioned.fill(child: Center(child: Icon(Icons.play_circle_fill, color: Colors.white70, size: 30))),
          ],
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: ClipRRect(borderRadius: BorderRadius.circular(8), child: SizedBox(width: 80, height: 80, child: thumb)),
          ),
          Positioned(
            top: -8,
            right: -2,
            child: GestureDetector(
              onTap: widget.onRemove,
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

  Widget _errorBox() => Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
    child: const Icon(Icons.error_outline, color: Colors.red),
  );

  Widget _loadingBox() => Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
    child: const Center(child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))),
  );
}

class _MediaPreviewDialog extends StatefulWidget {
  const _MediaPreviewDialog({required this.path, required this.isImage});
  final String path;
  final bool isImage;

  @override
  State<_MediaPreviewDialog> createState() => _MediaPreviewDialogState();
}

class _MediaPreviewDialogState extends State<_MediaPreviewDialog> {
  VideoPlayerController? _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isImage) {
      if (widget.path.startsWith('http')) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path));
      } else {
        _controller = VideoPlayerController.file(File(widget.path));
      }
      _controller!.initialize().then((_) {
        if (mounted) setState(() => _initialized = true);
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.black87,
    insetPadding: const EdgeInsets.all(16),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black,
        child: Center(
          child:
              widget.isImage
                  ? (widget.path.startsWith('http')
                      ? Image.network(widget.path, fit: BoxFit.contain)
                      : Image.file(File(widget.path), fit: BoxFit.contain))
                  : _controller == null
                  ? const SizedBox.shrink()
                  : _initialized
                  ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio == 0 ? 16 / 9 : _controller!.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller!),
                        _ControlsOverlay(controller: _controller!),
                        VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(playedColor: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  )
                  : const CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      ),
    ),
  );
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => controller.value.isPlaying ? controller.pause() : controller.play(),
    child: Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child:
              controller.value.isPlaying
                  ? const SizedBox.shrink()
                  : Container(
                    color: Colors.black26,
                    child: const Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 64)),
                  ),
        ),
      ],
    ),
  );
}
