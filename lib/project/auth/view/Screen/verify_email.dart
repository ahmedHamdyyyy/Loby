import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../../core/utils/utile.dart';
import '../../logic/auth_cubit.dart';
import 'confirm_otp.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendVerificationEmail(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().verifyEmail(_emailController.text.trim());
    }
  }

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
            MaterialPageRoute(builder: (context) => ConfirmOtpScreen(email: _emailController.text.trim(), willSignup: true)),
          );
          break;
        default:
          break;
      }
    },
    child: Scaffold(
      appBar: AppBar(title: Text(context.l10n.verifyEmailTitle), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email_outlined, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              Text(context.l10n.emailHint, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: context.l10n.email, border: const OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return context.l10n.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _sendVerificationEmail(context),
                child: Text(context.l10n.sendVerificationEmailButton),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
