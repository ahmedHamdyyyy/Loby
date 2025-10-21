import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/helper.dart';
import '../../../../../core/localization/l10n_ext.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 24),
          color: const Color(0xFF757575),
        ),
        TextWidget(
          text: context.l10n.termsAndConditions,
          color: const Color(0xFF757575),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class TermsTitle extends StatelessWidget {
  const TermsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
      child: TextWidget(
        text: context.l10n.termsAndConditions,
        color: const Color(0xFF1C1C1C),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class TermsContentSection extends StatelessWidget {
  const TermsContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TermsParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 95,
        ),
        TermsParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 191,
          lineHeight: 1.5,
        ),
        TermsParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 191,
          lineHeight: 1.5,
        ),
      ],
    );
  }
}

class TermsParagraph extends StatelessWidget {
  final String text;
  final double height;
  final double lineHeight;

  const TermsParagraph({super.key, required this.text, required this.height, this.lineHeight = 1.3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: height,
        width: 335,
        child: Text(
          textAlign: TextAlign.start,
          text,
          style: GoogleFonts.poppins(
            color: const Color(0xFF757575),
            fontSize: 16,
            height: lineHeight,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class AgreementCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onToggle;

  const AgreementCheckbox({super.key, required this.isChecked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onToggle,
          icon:
              isChecked
                  ? SvgPicture.asset(ImageAssets.cracalBlack, height: 24, width: 24)
                  : SvgPicture.asset(ImageAssets.cracalWhite, height: 24, width: 24),
          label: TextWidget(
            text: context.l10n.agreeToTerms,
            color: const Color(0xFF414141),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF262626),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: TextWidget(
            text: context.l10n.confirmButton,
            color: const Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
