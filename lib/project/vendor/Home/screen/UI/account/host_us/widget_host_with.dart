import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/widget/helper.dart';

class HostHeader extends StatelessWidget {
  const HostHeader({super.key});

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
          const TextWidget(text: 'Host With Us', color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}

class HostTitle extends StatelessWidget {
  const HostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [TextWidget(text: 'Host With Us', color: Color(0xFF1C1C1C), fontSize: 16, fontWeight: FontWeight.w600)],
      ),
    );
  }
}

class HostDescription extends StatelessWidget {
  const HostDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        textAlign: TextAlign.center,
        'Register your property and the tourist activities with lobby in regular way and get additional income you will now be directed to the lobby business app to register',
        style: GoogleFonts.poppins(color: const Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RegisterButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20.0),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF262626),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const TextWidget(text: 'Register', color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
