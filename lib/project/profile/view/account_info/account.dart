import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import 'widgets_accounts.dart';

class ProfileFeaturesScreen extends StatelessWidget {
  const ProfileFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.whiteColor,
    body: SingleChildScrollView(child: Column(children: [SizedBox(height: 44), AccountHeader(), AccountProfileCard()])),
  );
}
