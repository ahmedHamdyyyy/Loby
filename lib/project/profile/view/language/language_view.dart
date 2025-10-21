import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n_ext.dart';
import '../../../../core/localization/localization_cubit.dart';
import 'widget_lang.dart';

class LanguageViewVendor extends StatefulWidget {
  const LanguageViewVendor({super.key});

  @override
  State<LanguageViewVendor> createState() => _LanguageViewVendorState();
}

class _LanguageViewVendorState extends State<LanguageViewVendor> {
  // Using an enum for language selection to make code more maintainable
  Language selectedLanguage = Language.english;
  bool _initialized = false;

  void _selectLanguage(Language language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final code = context.read<LocalizationCubit>().state?.languageCode ?? Localizations.localeOf(context).languageCode;
      selectedLanguage = code == 'ar' ? Language.arabic : Language.english;
      _initialized = true;
    }
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
              title: context.l10n.english,
              isSelected: selectedLanguage == Language.english,
              onTap: () => _selectLanguage(Language.english),
            ),
            LanguageOption(
              title: context.l10n.arabic,
              isSelected: selectedLanguage == Language.arabic,
              onTap: () => _selectLanguage(Language.arabic),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SaveButton(
                onPressed: () async {
                  final locale = selectedLanguage == Language.arabic ? const Locale('ar') : const Locale('en');
                  await context.read<LocalizationCubit>().setLocale(locale);
                  if (mounted) Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
