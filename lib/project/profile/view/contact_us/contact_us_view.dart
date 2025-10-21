import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_ext.dart';
import 'widgets_contact_us_view.dart';

class ContactUsViewVendor extends StatelessWidget {
  const ContactUsViewVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContactUsHeader(),
              const SizedBox(height: 14),
              const ContactUsTitle(),
              const SizedBox(height: 16),
              const PhoneNumberRow(),
              const SizedBox(height: 24),
              const MessageSection(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SendButton(
                  onPressed: () {
                    // Handle send message action
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(context.l10n.messageSentSuccessfully)));
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
