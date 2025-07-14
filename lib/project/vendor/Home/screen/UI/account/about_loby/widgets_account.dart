import 'package:flutter/material.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/assets.dart';
import '../../../../../../../config/widget/common_styles.dart';

class AboutLobyImage extends StatelessWidget {
  const AboutLobyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 198,
          width: double.infinity,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AssetsData.loby), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class AboutLobyShortDescription extends StatelessWidget {
  const AboutLobyShortDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.horizontal,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          textAlign: TextAlign.start,
          style: TextStyles.body(size: 16, color: AppColors.grayTextColor, height: 1.3),
        ),
      ),
    );
  }
}

class AboutLobyLongDescription extends StatelessWidget {
  const AboutLobyLongDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.horizontal,
      child: Text(
        'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
        textAlign: TextAlign.start,
        style: TextStyles.body(size: 16, color: AppColors.grayTextColor, height: 1.5),
      ),
    );
  }
}
