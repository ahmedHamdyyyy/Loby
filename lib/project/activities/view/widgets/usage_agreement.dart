import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/widget/widgets.dart';
import 'wideger_activity.dart';

class UsageAgreement extends StatefulWidget {
  const UsageAgreement({super.key, required this.setAgreement});
  final void Function(bool) setAgreement;
  @override
  State<UsageAgreement> createState() => _UsageAgreementState();
}

class _UsageAgreementState extends State<UsageAgreement> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) => Scaffold(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() => isChecked = value!);
                    widget.setAgreement(isChecked);
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'I agree to all the terms and conditions',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondGrayTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
