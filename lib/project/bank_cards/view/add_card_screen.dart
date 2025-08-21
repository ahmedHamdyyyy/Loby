import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/common_styles.dart';
import '../../../../../config/widget/helper.dart';
import 'all_wideget_bank_card.dart';

class AddCardScreenVendor extends StatefulWidget {
  const AddCardScreenVendor({super.key});

  @override
  State<AddCardScreenVendor> createState() => _AddCardScreenVendorState();
}

class _AddCardScreenVendorState extends State<AddCardScreenVendor> {
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // String _rawCardNumber = '';
  bool _saveData = false;
  bool _isCardNumberValid = false;
  bool _isExpirationValid = false;
  bool _isCvvValid = false;
  bool _isCardNameValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: appBarPop(context, "Add Card", AppColors.primaryTextColor),
      body: SingleChildScrollView(
        padding: Paddings.standard,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardFormHeader(),
              const SizedBox(height: 20),
              CardNumberField(controller: _cardNumberController, onChanged: handleCardNumberChange),
              const SizedBox(height: 10),
              CardholderNameField(controller: _cardNameController, onChanged: handleCardNameChange),
              const SizedBox(height: 10),
              CardExpiryAndCvv(
                expirationController: _expirationController,
                cvvController: _cvvController,
                onExpirationChanged: handleExpirationChange,
                onCvvChanged: handleCvvChange,
              ),
              const SizedBox(height: 10),
              SaveDataOption(isSaveEnabled: _saveData, onToggle: toggleSaveData),
              const SizedBox(height: 20),
              AddCardButton(isFormValid: isFormValid(), onPressed: addCard),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String formatCardNumber(String input) {
    String cleanInput = input.replaceAll(RegExp(r'\D'), '');
    // _rawCardNumber = cleanInput;
    _isCardNumberValid = cleanInput.length == 16;

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < cleanInput.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleanInput[i]);
    }
    return buffer.toString();
  }

  int min(int a, int b) => a < b ? a : b;

  void handleCardNumberChange(String value) {
    setState(() {
      String formatted = formatCardNumber(value);
      _cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  void handleCardNameChange(String value) {
    setState(() {
      _isCardNameValid = value.trim().length > 2;
    });
  }

  void handleExpirationChange(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) {
      _expirationController.text = '';
      _isExpirationValid = false;
      return;
    }

    String formatted = '';

    if (digitsOnly.isNotEmpty) {
      int firstDigit = int.parse(digitsOnly[0]);
      if (firstDigit > 1) digitsOnly = '0$digitsOnly';
    }

    if (digitsOnly.length >= 2) {
      int month = int.parse(digitsOnly.substring(0, 2));
      if (month < 1) {
        digitsOnly = '01${digitsOnly.substring(2)}';
      } else if (month > 12) {
        digitsOnly = '12${digitsOnly.substring(2)}';
      }
    }

    if (digitsOnly.isNotEmpty) {
      formatted += digitsOnly.substring(0, min(2, digitsOnly.length));

      if (digitsOnly.length > 2) {
        formatted += '/${digitsOnly.substring(2, min(4, digitsOnly.length))}';
      } else if (digitsOnly.length == 2) {
        formatted += '/';
      }
    }

    _isExpirationValid = false;
    if (digitsOnly.length == 4) {
      int currentYear = DateTime.now().year % 100;
      int currentMonth = DateTime.now().month;

      int inputMonth = int.parse(digitsOnly.substring(0, 2));
      int inputYear = int.parse(digitsOnly.substring(2, 4));

      if ((inputYear > currentYear) || (inputYear == currentYear && inputMonth >= currentMonth)) _isExpirationValid = true;
    }

    _expirationController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void handleCvvChange(String value) => setState(() => _isCvvValid = value.length == 3);

  void toggleSaveData() => setState(() => _saveData = !_saveData);

  bool isFormValid() => _isCardNumberValid && _isExpirationValid && _isCvvValid && _isCardNameValid;

  void addCard() {
    if (isFormValid()) {
      /*    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SavedCardsScreen()),
      ); */

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Card details added successfully"), backgroundColor: Colors.green));
    }
  }
}
