// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'widgets_accounts.dart';

class AccountAfterSaveScreenVendor extends StatefulWidget {
  const AccountAfterSaveScreenVendor({super.key});

  @override
  State<AccountAfterSaveScreenVendor> createState() => _AccountAfterSaveScreenState();
}

class _AccountAfterSaveScreenState extends State<AccountAfterSaveScreenVendor> {
  bool isEditing = false;

  final TextEditingController firstNameController = TextEditingController(text: "Mostafa");
  final TextEditingController lastNameController = TextEditingController(text: "Abdallah");
  final TextEditingController phoneController = TextEditingController(text: "+966 123456789");
  final TextEditingController emailController = TextEditingController(text: "info@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "********");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Account info",
        onBack: () => Navigator.pop(context),
        onEdit: !isEditing ? _enableEditing : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ProfileImage(),
            const SizedBox(height: 10),
            ProfileNameAndEmail(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
            ),
            const SizedBox(height: 20),
            ProfileForm(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              phoneController: phoneController,
              emailController: emailController,
              passwordController: passwordController,
              isEditing: isEditing,
            ),
            const SizedBox(height: 20),
            ActionButton(
              label: isEditing ? "Save" : "Delete Account",
              onPressed: () {
                if (isEditing) {
                  _saveChanges();
                } else {
                  _showDeleteDialog(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _enableEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void _saveChanges() {
    setState(() {
      isEditing = false;
    });
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DeleteAccountDialog(
        onConfirm: () {
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
