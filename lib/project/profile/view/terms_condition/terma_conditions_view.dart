import 'package:Luby/core/localization/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFFFFFF),
    appBar: AppBar(backgroundColor: const Color(0xFFFFFFFF), elevation: 0, title: Text(context.l10n.termsAndConditions)),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Text(
          textAlign: TextAlign.start,
          context.l10n.termsAndConditions,
          style: GoogleFonts.poppins(color: const Color(0xFF757575), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}
