import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../Home/screen/UI/home_rental_services/main_vandor_home.dart';
import '../../../Home/screen/UI/splash/splash_screens.dart';
import '../../cubit/auth_cubit.dart';
import '../Widget/all_widget_auth.dart';
import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى ملء جميع الحقول')));
      return;
    }
    context.read<AuthCubit>().signin(email: email, password: password);
  }

  void _handleCreateAccount() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.signinStatus == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg), backgroundColor: Colors.red));
        } else if (state.signinStatus == Status.success) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainVendorHome()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryIcon),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreens()));
            },
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                LoginScreenContent(
                  emailController: emailController,
                  passwordController: passwordController,
                  obscurePassword: obscurePassword,
                  onTogglePassword: () => setState(() => obscurePassword = !obscurePassword),
                  onContinue: _handleLogin,
                  onCreateAccount: _handleCreateAccount,
                  onGoogleContinue: () {},
                  onFacebookContinue: () {},
                  onGuestLogin: () {},
                ),
                if (state.signinStatus == Status.loading)
                  Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
              ],
            );
          },
        ),
      ),
    );
  }
}
