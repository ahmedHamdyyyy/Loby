import 'package:flutter/material.dart';

import 'widget_term.dart';

class TermaConditionsViewVendor extends StatefulWidget {
  const TermaConditionsViewVendor({super.key});

  @override
  State<TermaConditionsViewVendor> createState() => _TermaConditionsViewVendor();
}

class _TermaConditionsViewVendor extends State<TermaConditionsViewVendor> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            const NavigationHeader(),
            const SizedBox(height: 14),
            const TermsTitle(),
            const TermsContentSection(),
            AgreementCheckbox(isChecked: _isChecked, onToggle: _toggleCheckbox),
            const SizedBox(height: 14),
            const DoneButton(),
          ],
        ),
      ),
    );
  }
}
