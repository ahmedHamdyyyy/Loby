import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';

// ------------------------ Text Widget ------------------------

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const TextWidget({super.key, required this.text, required this.color, required this.fontSize, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.poppins(color: color, fontSize: fontSize, fontWeight: fontWeight));
  }
}

// ------------------------ First Splash Screen Content ------------------------

class FirstSplashScreenContent extends StatelessWidget {
  final VoidCallback onGetStarted;

  const FirstSplashScreenContent({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image with Overlay
        Stack(
          children: [
            Image.asset(ImageAssets.firstSplashScreen, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            Container(color: Colors.black.withAlpha(75)),
          ],
        ),

        // Content (Welcome Text and Button)
        Positioned(
          bottom: 80,
          left: 20,
          right: 20,
          child: Column(
            children: [
              const TextWidget(
                text: "Welcome to LOBY",
                color: AppColors.primaryWhite,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 335,
                child: TextWidget(
                  text:
                      "LLorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.",
                  color: AppColors.primaryWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              StartedButton(onPressed: onGetStarted),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------------ Started Button ------------------------

class StartedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(159, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: const TextWidget(
        text: "Let's Started",
        color: AppColors.primaryWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

// ------------------------ Language Selection Screen Content ------------------------

class LanguageSelectionScreenContent extends StatelessWidget {
  final VoidCallback onSelectEnglish;
  final VoidCallback onSelectArabic;

  const LanguageSelectionScreenContent({super.key, required this.onSelectEnglish, required this.onSelectArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 210.h),
        Center(child: Image.asset('assets/images/logo1.png', width: 150.w)),
        const Spacer(),
        LanguageSelectionContainer(onSelectEnglish: onSelectEnglish, onSelectArabic: onSelectArabic),
      ],
    );
  }
}

// ------------------------ Language Selection Container ------------------------

class LanguageSelectionContainer extends StatelessWidget {
  final VoidCallback onSelectEnglish;
  final VoidCallback onSelectArabic;

  const LanguageSelectionContainer({super.key, required this.onSelectEnglish, required this.onSelectArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 372.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              text: "Select your Language",
              color: AppColors.secondTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 8.h),
            const TextWidget(text: "اختر لغتك", color: AppColors.secondTextColor, fontSize: 20, fontWeight: FontWeight.w500),
            SizedBox(height: 32.h),
            LanguageButton(language: "English", isPrimary: true, onPressed: onSelectEnglish),
            SizedBox(height: 16.h),
            LanguageButton(language: "العربية", isPrimary: false, onPressed: onSelectArabic),
          ],
        ),
      ),
    );
  }
}

// ------------------------ Language Button ------------------------

class LanguageButton extends StatelessWidget {
  final String language;
  final bool isPrimary;
  final VoidCallback onPressed;

  const LanguageButton({super.key, required this.language, required this.isPrimary, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: AppColors.primary,
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: Text(language, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp)),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: Text(language, style: GoogleFonts.poppins(fontSize: 16.sp, color: AppColors.primary)),
      );
    }
  }
}

// ------------------------ Splash Page View Widget ------------------------

class SplashPageView extends StatelessWidget {
  final PageController pageController;
  final List<Map<String, String>> splashData;

  const SplashPageView({super.key, required this.pageController, required this.splashData});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: splashData.length,
      itemBuilder: (context, index) {
        return SplashPageItem(
          imageUrl: splashData[index]["image"]!,
          title: splashData[index]["title"]!,
          description: splashData[index]["description"]!,
        );
      },
    );
  }
}

// ------------------------ Splash Page Item Widget ------------------------

class SplashPageItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const SplashPageItem({super.key, required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imageUrl, fit: BoxFit.cover),
        Container(color: Colors.black.withAlpha(75)),
        Positioned(
          bottom: 140,
          left: 20,
          right: 20,
          child: SizedBox(
            width: 335,
            child: Column(
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 24),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 16.0 * 0.065,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------ Page Indicator Widget ------------------------

class SplashPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const SplashPageIndicator({super.key, required this.pageController, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: itemCount,
        effect: const ExpandingDotsEffect(
          activeDotColor: AppColors.primary,
          dotColor: Colors.white,
          dotHeight: 16,
          dotWidth: 16,
          expansionFactor: 3,
        ),
      ),
    );
  }
}

// ------------------------ Skip Button Widget ------------------------

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text("Skip", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
    );
  }
}

// ------------------------ Splash Screens Content Widget ------------------------

class SplashScreensContent extends StatelessWidget {
  final PageController pageController;
  final List<Map<String, String>> splashData;
  final VoidCallback onSkip;

  const SplashScreensContent({super.key, required this.pageController, required this.splashData, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PageView with splash screens
        SplashPageView(pageController: pageController, splashData: splashData),

        // Page indicator dots
        Positioned(
          bottom: 80,
          left: 0,
          right: 0,
          child: SplashPageIndicator(pageController: pageController, itemCount: splashData.length),
        ),

        // Skip button
        Positioned(top: 50, right: 20, child: SkipButton(onPressed: onSkip)),
      ],
    );
  }
}
