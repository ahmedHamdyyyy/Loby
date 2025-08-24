import 'package:flutter/material.dart';

import 'all_widget_onporsing.dart';
import 'splash_screens.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstSplashScreenContent(
        onGetStarted: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreens()));
        },
      ),
    );
  }
}
