import 'package:flutter/material.dart';

import '../../../../../../config/colors/colors.dart';
import 'all_widget_onporsing.dart';
import 'first_splash_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.primary,
    body: LanguageSelectionScreenContent(
      onSelectEnglish:
          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen())),
      onSelectArabic:
          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen())),
    ),
  );
}
