import 'package:flutter/material.dart';

import '../../../../../../../config/widget/helper.dart';

enum Language { english, arabic }

class LanguageScreenHeader extends StatelessWidget {
  const LanguageScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 24),
            color: const Color(0xFF757575),
          ),
          const TextWidget(text: 'Language', color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}

/// Title widget for language screen
class LanguageScreenTitle extends StatelessWidget {
  const LanguageScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextWidget(text: 'Choose Your Language', color: Color(0xFF1C1C1C), fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

/// Individual language option
class LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({super.key, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RadioIndicator(isSelected: isSelected),
            ),
            Text(
              title,
              style: const TextStyle(color: Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

/// Radio indicator for language selection
class RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const RadioIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(color: Color(0xFF262626), shape: BoxShape.circle),
      child: isSelected
          ? Center(
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            )
          : null,
    );
  }
}

/// Save button for language selection
class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF262626),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
