import 'package:flutter/material.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/widget/widgets.dart';
import 'wideger_activity.dart';

class UsageAgreement extends StatefulWidget {
  const UsageAgreement({super.key});

  @override
  State<UsageAgreement> createState() => _UsageAgreementState();
}

class _UsageAgreementState extends State<UsageAgreement> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, 'Usage Agreement', AppColors.primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AgreementTitle(),
              const SizedBox(height: 24),
              const AgreementContent(),
              const SizedBox(height: 30),
              AgreementCheckbox(
                isChecked: isChecked,
                onToggle: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
