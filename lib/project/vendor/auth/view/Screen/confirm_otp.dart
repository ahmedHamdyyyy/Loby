import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../../../locator.dart';
import '../../../../models/user.dart';
import '../../../cubit/auth_cubit.dart';
import '../splash/splash_screens.dart';
import 'reset_password.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({super.key, this.user, required this.willSignup, required this.email});
  final UserModel? user;
  final String email;
  final bool willSignup;
  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  void _confirmOtp() async {
    _errorText = null;
    setState(() => _isLoading = true);
    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      _errorText = 'Please enter a valid OTP';
      setState(() => _isLoading = false);
      return;
    }
    context.read<AuthCubit>().confirmOtp(widget.email, _otpController.text, widget.willSignup);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.confirmOtpStatus) {
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.success:
          if (widget.willSignup) {
            getIt.get<AuthCubit>().signup(widget.user!);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email)));
          }
          break;
        default:
          break;
      }
      switch (state.signupStatus) {
        case Status.initial:
          break;
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.success:
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreens()));

          break;
        default:
          break;
      }
    },
    builder: (context, state) {
      if (state.confirmOtpStatus == Status.loading || state.signupStatus == Status.loading) {
        _isLoading = true;
      } else {
        _isLoading = false;
      }
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the OTP sent to ${widget.email}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _otpController,
                maxLength: 6,
                decoration: InputDecoration(labelText: 'OTP', errorText: _errorText, border: const OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _confirmOtp,
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          : const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
