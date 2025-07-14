import 'package:flutter/material.dart';

import 'widget_lang.dart';

class LanguageViewVendor extends StatefulWidget {
  const LanguageViewVendor({super.key});

  @override
  State<LanguageViewVendor> createState() => _LanguageViewVendorState();
}

class _LanguageViewVendorState extends State<LanguageViewVendor> {
  // Using an enum for language selection to make code more maintainable
  Language selectedLanguage = Language.english;

  void _selectLanguage(Language language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LanguageScreenHeader(),
            const SizedBox(height: 30),
            const LanguageScreenTitle(),
            const SizedBox(height: 16),
            LanguageOption(
              title: 'English',
              isSelected: selectedLanguage == Language.english,
              onTap: () => _selectLanguage(Language.english),
            ),
            LanguageOption(
              title: 'اللغة العربية',
              isSelected: selectedLanguage == Language.arabic,
              onTap: () => _selectLanguage(Language.arabic),
            ),
            const Spacer(),
            Padding(padding: const EdgeInsets.all(20.0), child: SaveButton(onPressed: () => Navigator.pop(context))),
          ],
        ),
      ),
    );
  }
}
