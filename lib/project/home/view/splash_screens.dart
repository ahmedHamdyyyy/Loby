// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../auth/view/Screen/sign_in.dart';
import 'all_widget_onporsing.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> splashData = [
    {
      "image": "assets/images/image2.png",
      "title": "Explore Saudi Arabia",
      "description":
          "Lorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.",
    },
    {
      "image": "assets/images/image3.png",
      "title": "Explore Saudi Arabia",
      "description":
          "Lorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.",
    },
    {
      "image": "assets/images/image4.png",
      "title": "Explore Saudi Arabia",
      "description":
          "Lorem ipsum dolor sit amet, consecr adipiscing elit. Ut hendrerit triueasdwfa prm gravida felis, sociis in felis.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreensContent(
        pageController: _pageController,
        splashData: splashData,
        onSkip: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        },
      ),
    );
  }
}
