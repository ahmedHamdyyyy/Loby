import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/colors/colors.dart';
import 'all_widget_onporsing.dart';
import 'first_splash_screen.dart';
import '../../../core/localization/localization_cubit.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.primary,
    body: LanguageSelectionScreenContent(
      onSelectEnglish: () {
        context.read<LocalizationCubit>().setLocale(const Locale('en'));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen()));
      },
      onSelectArabic: () {
        context.read<LocalizationCubit>().setLocale(const Locale('ar'));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstSplashScreen()));
      },
    ),
  );
}
