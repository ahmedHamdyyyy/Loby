import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../cubit/auth_cubit.dart';
import 'confirm_otp.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _sendVerificationEmail(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().verifyEmail(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.verifyEmailStatus) {
        case Status.loading:
          _isLoading = true;
          setState(() {});
          break;
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          _isLoading = false;
          setState(() {});
          break;
        case Status.success:
          _isLoading = false;
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ConfirmOtpScreen(email: _emailController.text.trim(), willSignup: true);
              },
            ),
          );
          break;
        default:
          break;
      }
    },
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Verify Email'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email_outlined, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text('Enter your email', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _isLoading ? null : _sendVerificationEmail(context),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          : const Text('Send Verification Email'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
