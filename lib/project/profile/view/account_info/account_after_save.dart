// ignore_for_file: library_private_types_in_public_api

import 'package:Luby/project/profile/logic/cubit.dart';
import 'package:Luby/project/profile/view/account_info/update_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../auth/view/Widget/wideget_sign_up.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isEditing = false;
  String _imageUrl = '';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  void _handleButtonAction() {
    showDeleteAccountDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //if (state.fetchUserStatus == Status.success) {
          firstNameController.text = state.user.firstName;
          lastNameController.text = state.user.lastName;
          phoneController.text = state.user.phone;
          _imageUrl = state.user.profilePicture;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(
              isEditing: isEditing,
              onEditPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAccountScreen(user: state.user)));
              },
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    imageUrl: _imageUrl,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: state.user.email,
                  ),
                  AccountFormFields(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
                    isEditing: isEditing,
                  ),
                  ActionButton(isEditing: isEditing, onPressed: _handleButtonAction),
                ],
              ),
            ),
          );
       /*  } *//*  else if (state.fetchUserStatus == Status.loading || state.fetchUserStatus == Status.initial) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(isEditing: isEditing, onEditPressed: () {}),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AccountInfoAppBar(isEditing: isEditing, onEditPressed: () {}),
            body: const Center(child: Text("Something went wrong!")),
          );
        } */
      },
    );
  }
}
