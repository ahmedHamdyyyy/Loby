import 'package:flutter/material.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/widget/common_styles.dart';
import 'widgets_account.dart';

class AboutLobyViewVendor extends StatelessWidget {
  const AboutLobyViewVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            CommonWidgets.headerWithBack(context: context, title: 'About lOBY'),
            const SizedBox(height: 14),
            CommonWidgets.pageTitle(title: 'About lOBY'),
            const AboutLobyImage(),
            const SizedBox(height: 30),
            const AboutLobyShortDescription(),
            const SizedBox(height: 16),
            const AboutLobyLongDescription(),
          ],
        ),
      ),
    );
  }
}
