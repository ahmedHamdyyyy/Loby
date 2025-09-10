// ignore_for_file: deprecated_member_use

import 'package:Luby/project/auth/view/Widget/wideget_sign_up.dart';
import 'package:Luby/project/profile/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../../../core/utils/utile.dart';
import '../../../../../../locator.dart';
import '../../../../models/user.dart';
import 'widgets_accounts.dart';

class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key, required this.user});
  final UserModel user;
  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  bool agreeToTerms = false;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController(), lastNameController = TextEditingController();
  final phoneController = TextEditingController(), emailController = TextEditingController();
  String _imagePath = '';
  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    phoneController.text = widget.user.phone;
    emailController.text = widget.user.email;
    _imagePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AccountInfoHeader(),
                const SizedBox(height: 15),
                EditableProfileImageWidget(image: _imagePath, onImageChanged: (imagePath) => _imagePath = imagePath),
                ProfileInfoText(firstName: widget.user.firstName, lastName: widget.user.lastName, email: widget.user.email),
                RegistrationTextField(controller: firstNameController, hintText: widget.user.firstName, isError: false),
                RegistrationTextField(controller: lastNameController, hintText: widget.user.lastName, isError: false),
                RegistrationTextField(
                  controller: phoneController,
                  hintText: widget.user.phone,
                  isNumber: true,
                  isError: false,
                ),
                const SizedBox(height: 10),
                TermsCheckbox(value: agreeToTerms, onChanged: (value) => setState(() => agreeToTerms = value)),
                const SizedBox(height: 20),
                BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state.updateUserStatus == Status.loading) {
                      Utils.loadingDialog(context);
                    } else if (state.updateUserStatus == Status.success) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showToast(text: "Profile updated successfully", stute: ToustStute.success);
                    } else if (state.updateUserStatus == Status.error) {
                      Navigator.pop(context);
                      showToast(text: "Failed to update profile", stute: ToustStute.error);
                    }
                  },
                  child: SaveButton(
                    onPressed: () {
                      getIt<ProfileCubit>().updateUser(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phone: phoneController.text,
                        imagePath: _imagePath,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
