import 'package:Luby/core/localization/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/widget/helper.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});
  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFFFFFF),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                color: const Color(0xFF757575),
              ),
              TextWidget(
                text: context.l10n.contactUsTitle,
                color: const Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: TextWidget(
              text: context.l10n.contactUsTitle,
              color: const Color(0xFF1C1C1C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: context.l10n.howCanWeHelp,
                  color: const Color(0xFF636363),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: context.l10n.messageInputHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  maxLines: 7,
                  minLines: 7,
                  controller: _messageController,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final message = _messageController.text;
                  final uri = Uri(scheme: 'mailto', path: 'Info@lubyksa.com', query: 'body=${Uri.encodeComponent(message)}');
                  await launchUrl(uri);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF262626),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: TextWidget(
                  text: context.l10n.commonSend,
                  color: const Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    //bottomNavigationBar: const BottomNavBarWidget(),
  );
}
