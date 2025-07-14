import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/widget/helper.dart';

class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, size: 24),
            color: const Color(0xFF757575),
          ),
          const TextWidget(text: 'Privacy Policy', color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}

class PrivacyTitle extends StatelessWidget {
  const PrivacyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
      child: TextWidget(text: 'Privacy Policy', color: Color(0xFF1C1C1C), fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class PrivacyParagraph extends StatelessWidget {
  final String text;
  final double height;
  final double lineHeight;

  const PrivacyParagraph({super.key, required this.text, required this.height, this.lineHeight = 1.3});

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

class PrivacyContent extends StatelessWidget {
  const PrivacyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrivacyParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 95,
        ),
        PrivacyParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 191,
          lineHeight: 1.5,
        ),
        PrivacyParagraph(
          text:
              'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay prm gravida felis, sociis in felis.Diam habitant .',
          height: 191,
          lineHeight: 1.5,
        ),
      ],
    );
  }
}
