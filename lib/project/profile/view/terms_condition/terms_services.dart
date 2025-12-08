// Terms Checkbox
import 'package:Luby/core/localization/l10n_ext.dart';
import 'package:flutter/material.dart';

import '../../../../config/colors/colors.dart';
import 'terma_conditions_view.dart';

class TermsConditionsbox extends StatefulWidget {
  const TermsConditionsbox({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;

  @override
  State<TermsConditionsbox> createState() => _TermsConditionsboxState();
}

class _TermsConditionsboxState extends State<TermsConditionsbox> {
  bool value = false;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Checkbox(
        checkColor: AppColors.primary,
        fillColor: WidgetStateProperty.all(AppColors.whiteColor),
        value: value,
        onChanged: (newValue) {
          setState(() => value = newValue!);
          widget.onChanged(value);
        },
      ),
      Expanded(
        child: GestureDetector(
          onDoubleTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditionsView())),
          child: Text(
            context.l10n.agreeToTermsAndConditions,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
  );
}
