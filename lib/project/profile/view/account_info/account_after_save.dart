// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:Luby/project/profile/logic/cubit.dart';
import 'package:Luby/project/profile/view/account_info/update_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/localization/l10n_ext.dart';
import '../../../../core/utils/utile.dart';
import '../../../../locator.dart';
import '../../../../models/user.dart';
import '../../../auth/view/Screen/sign_up.dart';
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
  final confirmPasswordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final ibanController = TextEditingController();
  final certificateNumberController = TextEditingController();

  File? nationalIdDocument;
  File? ibanDocument;
  File? certificateNumberDocument;

  void _handleButtonAction() {
    showDeleteAccountDialog(context);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    nationalIdController.dispose();
    ibanController.dispose();
    certificateNumberController.dispose();
    super.dispose();
  }

  void _uploadDocuments() {
    if (nationalIdDocument == null || ibanDocument == null || certificateNumberDocument == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.pleaseSelectAllRequiredDocuments)));
      return;
    }

    getIt<ProfileCubit>().uploadDocuments(
      nationalId: nationalIdController.text,
      iban: ibanController.text,
      certificateNumber: certificateNumberController.text,
      nationalIdFile: nationalIdDocument!.path,
      ibanFile: ibanDocument!.path,
      certificateFile: certificateNumberDocument!.path,
    );
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
              if (state.user.status == UserStatus.pending) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(context.l10n.accountUnderReviewCannotEdit)));
              } else if (state.user.status == UserStatus.rejected) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(context.l10n.accountRejectedContactSupport)));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAccountScreen(user: state.user)));
              }
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
                if (state.user.status == UserStatus.rejected) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      context.l10n.accountRejectedContactSupport,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RegistrationTextField(hintText: context.l10n.nationalIdLabel, controller: nationalIdController),
                  RegistrationTextField(hintText: context.l10n.ibanLabel, controller: ibanController),
                  RegistrationTextField(
                    hintText: context.l10n.certificateNumberLabel,
                    controller: certificateNumberController,
                  ),
                  DocumentPicker(
                    label: context.l10n.nationalIdDocumentLabel,
                    file: nationalIdDocument,
                    onPick: (f) => setState(() => nationalIdDocument = f),
                  ),
                  DocumentPicker(
                    label: context.l10n.ibanDocumentLabel,
                    file: ibanDocument,
                    onPick: (f) => setState(() => ibanDocument = f),
                  ),
                  DocumentPicker(
                    label: context.l10n.certificateDocumentLabel,
                    file: certificateNumberDocument,
                    onPick: (f) => setState(() => certificateNumberDocument = f),
                  ),
                  const SizedBox(height: 10),
                  BlocListener<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state.uploadDocumentsStatus == Status.loading) {
                        Utils.loadingDialog(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.uploadingDocuments)));
                      } else if (state.uploadDocumentsStatus == Status.success) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(context.l10n.documentsUploadedSuccessfully)));
                      } else if (state.uploadDocumentsStatus == Status.error) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(context.l10n.errorWithMessage(state.callback))));
                      }
                    },
                    child: ElevatedButton(
                      onPressed: _uploadDocuments,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                      child: Text(context.l10n.uploadDocuments),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                ActionButton(isEditing: isEditing, onPressed: _handleButtonAction),
              ],
            ),
          ),
        );
        /*  } */ /*  else if (state.fetchUserStatus == Status.loading || state.fetchUserStatus == Status.initial) {
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
