// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/common_styles.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../../config/images/image_assets.dart';
import 'bank_cards2_screen.dart';

class EditCardScreenVendor extends StatefulWidget {
  const EditCardScreenVendor({super.key});

  @override
  State<EditCardScreenVendor> createState() => _EditCardScreenVendorState();
}

class _EditCardScreenVendorState extends State<EditCardScreenVendor> {
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _rawCardNumber = '';
  bool _saveData = false;
  bool _isCardNumberValid = false;
  bool _isExpirationValid = false;
  bool _isCvvValid = false;
  bool _isCardNameValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: appBarPop(context, "Edit Card", AppColors.primaryTextColor),
      body: SingleChildScrollView(
        padding: Paddings.standard,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardFormHeader(),
              const SizedBox(height: 20),
              CardNumberField(controller: _cardNumberController, onChanged: _handleCardNumberChange),
              const SizedBox(height: 10),
              CardholderNameField(controller: _cardNameController, onChanged: _handleCardNameChange),
              const SizedBox(height: 10),
              CardExpiryAndCvv(
                expirationController: _expirationController,
                cvvController: _cvvController,
                onExpirationChanged: _handleExpirationChange,
                onCvvChanged: _handleCvvChange,
              ),
              const SizedBox(height: 10),
              SaveDataOption(isSaveEnabled: _saveData, onToggle: _toggleSaveData),
              const SizedBox(height: 20),
              SaveButton(isFormValid: isFormValid(), onPressed: _saveCard),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String formatCardNumber(String input) {
    String cleanInput = input.replaceAll(RegExp(r'\D'), '');
    _rawCardNumber = cleanInput;
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

  String obscureCardNumber(String formattedInput) {
    if (_rawCardNumber.length <= 4) return formattedInput;

    String lastFourDigits = _rawCardNumber.substring(_rawCardNumber.length - 4);
    String maskedPart = "●●●● ●●●● ●●●● ";

    return maskedPart + lastFourDigits;
  }

  int min(int a, int b) => a < b ? a : b;

  void _handleCardNumberChange(String value) {
    setState(() {
      String formatted = formatCardNumber(value);
      _cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  void _handleCardNameChange(String value) {
    setState(() {
      _isCardNameValid = value.trim().length > 2;
    });
  }

  void _handleExpirationChange(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) {
      _expirationController.text = '';
      _isExpirationValid = false;
      return;
    }

    String formatted = '';

    if (digitsOnly.isNotEmpty) {
      int firstDigit = int.parse(digitsOnly[0]);
      if (firstDigit > 1) {
        digitsOnly = '0$digitsOnly';
      }
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

      if ((inputYear > currentYear) || (inputYear == currentYear && inputMonth >= currentMonth)) {
        _isExpirationValid = true;
      }
    }

    _expirationController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _handleCvvChange(String value) {
    setState(() {
      _isCvvValid = value.length == 3;
    });
  }

  void _toggleSaveData() {
    setState(() {
      _saveData = !_saveData;
    });
  }

  bool isFormValid() {
    return _isCardNumberValid && _isExpirationValid && _isCvvValid && _isCardNameValid;
  }

  void _saveCard() {
    if (isFormValid()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedCardsScreenVendor()));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Card details added successfully"), backgroundColor: Colors.green));
    }
  }
}

class CardFormHeader extends StatelessWidget {
  const CardFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Card details", style: TextStyles.title(color: AppColors.primaryColor));
  }
}

class CardNumberField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CardNumberField({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormField(
      label: "Card Number",
      controller: controller,
      hint: "0000 0000 0000 0000",
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
    );
  }
}

class CardholderNameField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CardholderNameField({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormField(
      label: "Card Name",
      controller: controller,
      hint: "Cardholder Name",
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
    );
  }
}

class CardExpiryAndCvv extends StatelessWidget {
  final TextEditingController expirationController;
  final TextEditingController cvvController;
  final Function(String) onExpirationChanged;
  final Function(String) onCvvChanged;

  const CardExpiryAndCvv({
    super.key,
    required this.expirationController,
    required this.cvvController,
    required this.onExpirationChanged,
    required this.onCvvChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FormField(
            label: "Expiration Date",
            controller: expirationController,
            hint: "MM/YY",
            keyboardType: TextInputType.number,
            onChanged: onExpirationChanged,
            formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FormField(
            label: "CVV",
            controller: cvvController,
            hint: "***",
            keyboardType: TextInputType.number,
            onChanged: onCvvChanged,
            obscureText: true,
            formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          ),
        ),
      ],
    );
  }
}

class SaveDataOption extends StatelessWidget {
  final bool isSaveEnabled;
  final VoidCallback onToggle;

  const SaveDataOption({super.key, required this.isSaveEnabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          child: isSaveEnabled ? SvgPicture.asset(ImageAssets.cracalBlack) : SvgPicture.asset(ImageAssets.cracalWhite),
        ),
        const SizedBox(width: 8),
        Text("Save data when paying later", style: TextStyles.body(color: AppColors.secondTextColor, size: 14)),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.isFormValid, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyles.primary(
          backgroundColor: isFormValid ? AppColors.primaryColor : AppColors.primaryColor.withAlpha(125),
        ),
        onPressed: isFormValid ? onPressed : null,
        child: Text("Save", style: TextStyles.button(size: 16)),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  const FormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.onChanged,
    this.obscureText = false,
    this.formatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.body(color: AppColors.secondTextColor, size: 16)),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyles.body(color: AppColors.grayTextColor, size: 16),
            inputFormatters: formatters,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyles.body(color: const Color(0xFFCBCBCB), size: 16),
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
