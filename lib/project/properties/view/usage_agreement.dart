import 'package:flutter/material.dart';

import '../../../../../config/widget/widgets.dart';
import 'all_properts_widget.dart';

class UsageAgreementScreen extends StatefulWidget {
  const UsageAgreementScreen({super.key});

  @override
  State<UsageAgreementScreen> createState() => _UsageAgreementScreenState();
}

class _UsageAgreementScreenState extends State<UsageAgreementScreen> {
  // Move state variables to class level
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, 'Usage agreement', Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AgreementTitle(),
            const SizedBox(height: 12),
            const AgreementSection(
              text: "With God's help and success, an agreement was reached on (Sunday) and the date (11/08/2024) between",
              isPrimary: false,
            ),
            const SizedBox(height: 8),
            const AgreementSection(text: 'Loby and the host name ( company name ) ', isPrimary: true),
            const AgreementSection(
              text: 'Registry No. 1437/27/11 , address, phone number , email address',
              isPrimary: false,
            ),
            const SizedBox(height: 12),
            const AgreementSection(text: 'Hereinafter referred to as (First Party, Jathran or Platform)', isPrimary: false),
            const SizedBox(height: 12),
            const AgreementSection(text: 'Mr. Y', isPrimary: true),
            const SizedBox(height: 12),
            const AgreementSection(
              text:
                  'Mr. Y Saudi nationality. Address: Saudi Arabia, Al-Kharj, Al-Baraka neighborhood, phone number (546325010), ID number (1104642127) and e-mail address E-mail (badrlafi@hotmail.com)',
              isPrimary: false,
            ),
            const SizedBox(height: 20),
            const AgreementSection(text: 'Hereinafter referred to as (Second Party or Host)', isPrimary: false),
            const SizedBox(height: 12),
            const AgreementSection(
              text:
                  'Whereas the first party has an online platform for booking and displaying vacation homes, including but not limited to (apartments and private villas. Chalets, camps, farms and others), licensed by the Ministry of Tourism, and whereas the second party owns or manages a property intended for rental and wishes to advertise it on the first party\'s platform, therefore the two parties have agreed, with their full capacity considered legally and lawfully, to enter into this agreement in accordance with the following:',
              isPrimary: false,
            ),
            const SizedBox(height: 12),
            const AgreementSection(
              text:
                  'Mr. Y  Saudi nationality. Address: Saudi Arabia, Al-Kharj, Al-Baraka neighborhood, phone number (546325010), ID number (1104642127) and e-mail address E-mail (badrlafi@hotmail.com)',
              isPrimary: false,
            ),
            const SizedBox(height: 16),
            AgreementCheckbox(
              isAgreed: isAgreed,
              onToggle: () {
                setState(() {
                  isAgreed = !isAgreed;
                });
              },
            ),
            const SizedBox(height: 20),
            ContinueButton(isEnabled: isAgreed),
          ],
        ),
      ),
    );
  }
}
