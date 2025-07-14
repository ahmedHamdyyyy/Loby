import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../Home/screen/UI/home_rental_services/main_vandor_home.dart';
import '../../../models/user_model.dart';
import '../../cubit/auth_cubit.dart';
import '../Widget/wideget_sign_up.dart';
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
    super.dispose();
  }

  void _handleSignUp() {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى الموافقة على الشروط والأحكام'), backgroundColor: Colors.red));
      return;
    }
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى ملء جميع الحقول'), backgroundColor: Colors.red));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('كلمات المرور غير متطابقة'), backgroundColor: Colors.red));
      return;
    }

    context.read<AuthCubit>().signup(
      UserModel(
        id: '',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text.trim(),
        phone: phoneController.text,
        password: passwordController.text,
        role: 'vendor',
        profilePicture: profileImage == null ? '' : profileImage!.path,
      ),
    );
  }

  void _handleImageSelected(File image) => setState(() => profileImage = image);

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state.signupStatus == Status.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg), backgroundColor: Colors.red));
      } else if (state.signupStatus == Status.success) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainVendorHome()));
      }
    },
    builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
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
                    RegistrationTextField(hintText: "رقم الهاتف", controller: phoneController, isNumber: true),
                    RegistrationTextField(hintText: "البريد الإلكتروني", controller: emailController),
                    RegistrationTextField(hintText: "كلمة المرور", controller: passwordController, isPassword: true),
                    RegistrationTextField(
                      hintText: "تأكيد كلمة المرور",
                      controller: confirmPasswordController,
                      isPassword: true,
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
                          style: GoogleFonts.poppins(
                            color: AppColors.grayTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInScreen()),
                            );
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
            if (state.signupStatus == Status.loading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      );
    },
  );
}
