// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/constants/constance.dart';
import '../../../../../../core/services/cach_services.dart';
import '../../../../../../locator.dart';
import '../../../../auth/view/Screen/sign_in.dart';
import '../home_rental_services/main_vandor_home.dart';
import 'language_selection_screen.dart';

class LubyScreenSplash extends StatefulWidget {
  const LubyScreenSplash({super.key});

  @override
  State<LubyScreenSplash> createState() => _LubyScreenSplashState();
}

class _LubyScreenSplashState extends State<LubyScreenSplash> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLoggedIn = getIt<CacheService>().storage.getString(AppConst.accessToken) != null;
    if (isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainVendorHome()));
    } else {
      final viewOnboarding = getIt<CacheService>().storage.getBool(AppConst.viewOnboarding) ?? true;
      if (viewOnboarding) {
        getIt<CacheService>().storage.setBool(AppConst.viewOnboarding, false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Image.asset('assets/images/logo1.png', width: 150.w)),
    );
  }
}
