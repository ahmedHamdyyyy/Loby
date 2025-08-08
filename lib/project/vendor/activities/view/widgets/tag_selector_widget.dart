import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';


class TagSelectorWidget extends StatefulWidget {

  const TagSelectorWidget({super.key, required this.selectedTags});

  final List<String> selectedTags;
  @override
  State<TagSelectorWidget> createState() => _TagSelectorScreenState();
}

class _TagSelectorScreenState extends State<TagSelectorWidget> {
  // Map to store the selection state of each tag
  final Map<String, bool> _selectedTags = {
    'Photography': false,
    'Transfer': false,
    'Pool': false,
    
    'Waterfront': false,
  };

  // Add your own tags here
  final List<String> _customTags = [];

  // Controller for the text field
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 10.0,
          children: [
            ..._selectedTags.keys.map((tag) => _buildTagChip(tag)),
            _buildAddTagChip(),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag) {
    final isSelected = _selectedTags[tag] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTags[tag] = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          tag,
          style: GoogleFonts.poppins(
            color: AppColors.blackColor,
            fontSize: 14,

            fontWeight: isSelected ? FontWeight.w400 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAddTagChip() {
    return GestureDetector(
      onTap: () {
        _showAddTagDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16, color: AppColors.grayTextColor),
            const SizedBox(width: 4),
            Text(
              'Add other things',
              style: GoogleFonts.poppins(
                color: AppColors.grayTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTagDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a new tag',
          style: GoogleFonts.poppins(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          ),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter tag name',
              hintStyle: GoogleFonts.poppins(
                color: AppColors.grayTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _textController.clear();
              },
              child: Text('Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.secondGrayTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() {
                    final newTag = _textController.text.trim();
                    if (!_selectedTags.containsKey(newTag)) {
                      _selectedTags[newTag] = true;
                      _customTags.add(newTag);
                    }
                  });
                  Navigator.of(context).pop();
                  _textController.clear();
                }
              },
              child: Text('Add',
              style: GoogleFonts.poppins(
                color: AppColors.secondGrayTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              ),
            ),
          ],
        );
      },
    );
  }
}
