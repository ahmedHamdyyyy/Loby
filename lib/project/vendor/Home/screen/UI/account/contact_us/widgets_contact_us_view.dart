import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../config/widget/helper.dart';

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({super.key});

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
          const TextWidget(text: 'Contact Us', color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}

class ContactUsTitle extends StatelessWidget {
  const ContactUsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
      child: TextWidget(text: 'Contact Us', color: Color(0xFF1C1C1C), fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class PhoneNumberRow extends StatelessWidget {
  const PhoneNumberRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          TextWidget(text: '+966 123456789', color: Color(0xFF636363), fontSize: 16, fontWeight: FontWeight.w400),
          Spacer(),
          CallButton(),
        ],
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(color: const Color(0xFF262626), borderRadius: BorderRadius.circular(10)),
        child: Padding(padding: const EdgeInsets.all(3.0), child: SvgPicture.asset('assets/images/call-calling.svg')),
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  const MessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: 'How can we help you ?', color: Color(0xFF636363), fontSize: 16, fontWeight: FontWeight.w400),
          SizedBox(height: 16),
          /*  CustomTextField(
            text: 'You can add your message here',
            maxLines: 7,
            height: 235,
            width: 335,
          ), */
        ],
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF262626),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const TextWidget(text: 'Send', color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
