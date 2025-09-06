import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../../core/utils/utile.dart';
import '../../../../locator.dart';
import '../../../../models/user.dart';
import '../../../home/view/main_vandor_home.dart';
import '../../logic/auth_cubit.dart';
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
  String? _errorText;

  void _confirmOtp() async {
    _errorText = null;
    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      _errorText = 'Please enter a valid OTP';
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
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.confirmOtpStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.error:
          Navigator.pop(context);
          Utils.errorDialog(context, state.msg);
          break;
        case Status.success:
          Navigator.pop(context);
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
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.error:
          Navigator.pop(context);
          Utils.errorDialog(context, state.msg);
          break;
        case Status.success:
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainVendorHome()),
            (route) => false,
          );
          break;
        default:
          break;
      }
    },
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to ${widget.email}', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              maxLength: 6,
              decoration: InputDecoration(labelText: 'OTP', errorText: _errorText, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _confirmOtp, child: const Text('Confirm'))),
          ],
        ),
      ),
    ),
  );
}
