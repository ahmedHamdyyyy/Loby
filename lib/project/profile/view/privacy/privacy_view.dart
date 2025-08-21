import 'package:flutter/material.dart';

import 'widget_privcy.dart';

class PrivacyViewVendor extends StatelessWidget {
  const PrivacyViewVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [PrivacyHeader(), SizedBox(height: 14), PrivacyTitle(), SizedBox(height: 30), PrivacyContent()],
          ),
        ),
      ),
    );
  }
}
