// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/constants/constance.dart';
import '../../../../../../core/services/cach_services.dart';
import '../../../../../../locator.dart';
import '../home_rental_services/main_vandor_home.dart';
import 'language_selection_screen.dart';

class LubyScreenSplash extends StatefulWidget {
  const LubyScreenSplash({super.key});

  @override
  State<LubyScreenSplash> createState() => _LubyScreenSplashState();
}

class _LubyScreenSplashState extends State<LubyScreenSplash> {
  final isLoggedIn = getIt<CacheService>().storage.getString(AppConst.user) != null;
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isLoggedIn ? const MainVendorHome() : const LanguageSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Image.asset('assets/images/logo1.png', width: 150.w)),
    );
  }
}
