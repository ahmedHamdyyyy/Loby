import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../../core/utils/utile.dart';
import '../../../../models/user.dart';
import '../../../home/view/pick_image_widget.dart';
import '../../logic/auth_cubit.dart';
import '../Widget/wideget_sign_up.dart';
import 'confirm_otp.dart';
import 'sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final ibanController = TextEditingController();
  final certificateNumberController = TextEditingController();

  File? nationalIdDocument;
  File? ibanDocument;
  File? certificateNumberDocument;

  bool agreeToTerms = false;
  File? profileImage;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nationalIdController.dispose();
    ibanController.dispose();
    certificateNumberController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.pleaseAgreeToTerms), backgroundColor: Colors.red));
      return;
    }
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        nationalIdController.text.isEmpty ||
        ibanController.text.isEmpty ||
        certificateNumberController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.formFillRequired), backgroundColor: Colors.red));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.passwordsDoNotMatch), backgroundColor: Colors.red));
      return;
    }

    context.read<AuthCubit>().verifyEmail(emailController.text.trim());
  }

  void _handleImageSelected(File image) => setState(() => profileImage = image);

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.verifyEmailStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.error:
          Navigator.pop(context);
          Utils.errorDialog(context, state.msg);
          break;
        case Status.success:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ConfirmOtpScreen(
                  user: UserModel.non.copyWith(
                    firstName: firstNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    password: passwordController.text.trim(),
                    role: AppConst.vendor,
                    profilePicture: profileImage == null ? '' : profileImage!.path,
                    nationalId: nationalIdController.text.trim(),
                    iban: ibanController.text.trim(),
                    certificateNumber: certificateNumberController.text.trim(),
                    nationalIdDocument: nationalIdDocument?.path ?? '',
                    ibanDocument: ibanDocument?.path ?? '',
                    certificateNumberDocument: certificateNumberDocument?.path ?? '',
                  ),
                  email: emailController.text.trim(),
                  willSignup: true,
                );
              },
            ),
          );
          break;
        default:
          break;
      }
    },
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SignUpHeader(),
              const SizedBox(height: 15),
              EditableProfileImage(onImageSelected: _handleImageSelected),
              const SizedBox(height: 30),
              RegistrationTextField(hintText: "الاسم الأول", controller: firstNameController, isError: false),
              RegistrationTextField(hintText: "اسم العائلة", controller: lastNameController),
              RegistrationTextField(
                //validator: (value) => InputValidation.phoneValidation(value),
                keyboardType: TextInputType.phone,
                hintText: "رقم الهاتف",
                controller: phoneController,
                isNumber: true,
              ),
              RegistrationTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: "البريد الإلكتروني",
                controller: emailController,
              ),
              RegistrationTextField(hintText: "كلمة المرور", controller: passwordController, isPassword: true),
              RegistrationTextField(hintText: "تأكيد كلمة المرور", controller: confirmPasswordController, isPassword: true),
              RegistrationTextField(hintText: "الرقم القومي", controller: nationalIdController),
              RegistrationTextField(hintText: "رقم الآيبان", controller: ibanController),
              RegistrationTextField(hintText: "رقم الشهادة", controller: certificateNumberController),
              DocumentPicker(
                label: 'مستند الهوية',
                file: nationalIdDocument,
                onPick: (f) => setState(() => nationalIdDocument = f),
              ),
              DocumentPicker(label: 'مستند الآيبان', file: ibanDocument, onPick: (f) => setState(() => ibanDocument = f)),
              DocumentPicker(
                label: 'مستند الشهادة',
                file: certificateNumberDocument,
                onPick: (f) => setState(() => certificateNumberDocument = f),
              ),
              const SizedBox(height: 10),
              TermsCheckbox(value: agreeToTerms, onChanged: (value) => setState(() => agreeToTerms = value)),
              const SizedBox(height: 20),
              SignUpButton(onPressed: _handleSignUp),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "لديك حساب بالفعل؟",
                    style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "تسجيل الدخول",
                      style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ),
  );
}

class DocumentPicker extends StatelessWidget {
  const DocumentPicker({super.key, required this.label, required this.onPick, this.file});
  final String label;
  final void Function(File) onPick;
  final File? file;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedFile = await FilePickerWidget.pickPdfFile(context);
        if (pickedFile != null) onPick(File(pickedFile.path));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.attach_file, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                file == null ? label : file!.path.split('/').last,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (file != null) const Icon(Icons.check_circle, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }
}
