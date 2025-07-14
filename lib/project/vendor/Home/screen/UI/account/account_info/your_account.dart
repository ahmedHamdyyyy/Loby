// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'widgets_accounts.dart';

class AccountInfoScreenVendor extends StatefulWidget {
  const AccountInfoScreenVendor({super.key});

  @override
  State<AccountInfoScreenVendor> createState() => _AccountInfoScreenVendorState();
}

class _AccountInfoScreenVendorState extends State<AccountInfoScreenVendor> {
  bool agreeToTerms = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 22),
              const NavigationHeader(title: "Account info"),
              const SizedBox(height: 10),
              const InfoHeader(title: "Please complete the following\ninformation"),
              const SizedBox(height: 15),
              const ProfileImageWithEdit(),
              const SizedBox(height: 10),
              const UserNameAndEmail(name: "Your Name", email: "info@gmail.com"),
              const SizedBox(height: 20),
              AccountFormFields(
                onToggleTerms: toggleTerms,
                isTermsAccepted: agreeToTerms,
                onTogglePasswordVisibility: togglePasswordVisibility,
                onToggleConfirmPasswordVisibility: toggleConfirmPasswordVisibility,
                isPasswordVisible: isPasswordVisible,
                isConfirmPasswordVisible: isConfirmPasswordVisible,
              ),
              const SizedBox(height: 20),
              SaveButton(onPressed: () => navigateToAccountAfterSave(context)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void toggleTerms() {
    setState(() {
      agreeToTerms = !agreeToTerms;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }
}
