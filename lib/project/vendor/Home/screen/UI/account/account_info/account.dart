import 'package:flutter/material.dart';

import '../../../../../../../config/colors/colors.dart';
import 'widgets_accounts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.whiteColor,
    body: SingleChildScrollView(child: Column(children: [SizedBox(height: 52), AccountHeader(), AccountProfileCard()])),
  );
}
