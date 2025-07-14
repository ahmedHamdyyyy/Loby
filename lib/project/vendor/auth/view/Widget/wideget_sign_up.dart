// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/helper.dart';

// Account App Bar widget
class AccountInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final VoidCallback onEditPressed;

  const AccountInfoAppBar({super.key, required this.isEditing, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Account info",
        style: TextStyle(color: AppColors.grayTextColor, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
      ),
      centerTitle: false,
      actions: [if (!isEditing) IconButton(icon: SvgPicture.asset(ImageAssets.editIcon), onPressed: onEditPressed)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Profile Header Widget (Avatar and name)
class ProfileHeaderWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileHeaderWidget({super.key, required this.firstName, required this.lastName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(radius: 50, backgroundImage: AssetImage(ImageAssets.profileImage)),
        const SizedBox(height: 10),
        Text(
          "$firstName $lastName",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final bool isPassword;

  const CustomTextField({super.key, required this.controller, required this.isEnabled, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: TextField(
          controller: controller,
          enabled: isEnabled,
          obscureText: isPassword,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.grayTextColor,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grayColorIcon),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grayColorIcon),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grayColorIcon),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grayColorIcon),
            ),
          ),
        ),
      ),
    );
  }
}

// Action Button Widget
class ActionButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.isEditing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            isEditing ? "Save" : "Delete Account",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}

// Delete Account Dialog Widget
class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Delete Account",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 1.2,
              width: 120,
              color: AppColors.primaryColor,
            ),
            const Text(
              "Are you sure about deleting your account?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // هنا تحط عملية حذف الحساب
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show delete account dialog
void showDeleteAccountDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const DeleteAccountDialog());
}

// Account Form Fields Widget
class AccountFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isEditing;

  const AccountFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(controller: firstNameController, isEnabled: isEditing),
        CustomTextField(controller: lastNameController, isEnabled: isEditing),
        CustomTextField(controller: phoneController, isEnabled: isEditing),
        CustomTextField(controller: emailController, isEnabled: isEditing),
        CustomTextField(controller: passwordController, isEnabled: isEditing, isPassword: true),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ----- New Account Screen Widgets -----

// Account Header Widget
class AccountHeaderWidget extends StatelessWidget {
  const AccountHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 52),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              "Account",
              style: TextStyle(
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Account Profile Card Widget
class AccountProfileCardWidget extends StatelessWidget {
  const AccountProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/images/profile.png",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Your Name",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.accountTextColor,
            fontFamily: 'Poppins',
          ),
        ),
        const Text(
          "info@gmail.com",
          style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Menu Item Widget
class MenuItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? screen;
  final bool showArrow;

  const MenuItemWidget({super.key, required this.icon, required this.title, required this.screen, this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 24, height: 24),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: showArrow ? 16 : 14,
          color: AppColors.accountTextColor,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: showArrow ? SvgPicture.asset(ImageAssets.arrowDown, height: 24, width: 24) : null,
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
        }
      },
    );
  }
}

// Account Card Widget
class AccountCardWidget extends StatelessWidget {
  final List<Widget> menuItems;

  const AccountCardWidget({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Column(children: [const AccountProfileCardWidget(), ...menuItems, const SizedBox(height: 20)]),
    );
  }
}

// Placeholder Screen Widget
class PlaceholderScreenWidget extends StatelessWidget {
  final String title;

  const PlaceholderScreenWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, title, AppColors.grayTextColor),
      body: const Center(
        child: Text(
          "Coming Soon...",
          style: TextStyle(fontSize: 20, color: Colors.grey, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}

// Placeholder screen classes
class RateLubycreen extends StatelessWidget {
  const RateLubycreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreenWidget(title: "Rate App");
  }
}

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreenWidget(title: "Invite Friends");
  }
}

// ----- Your Account Screen Widgets -----

// Account Info Header
class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
            ),
            const SizedBox(width: 8),
            const Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "Create your account to continue using the app ",
          // textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class EditableProfileImage extends StatefulWidget {
  final Function(File) onImageSelected;

  const EditableProfileImage({super.key, required this.onImageSelected});

  @override
  _EditableProfileImageState createState() => _EditableProfileImageState();
}

class _EditableProfileImageState extends State<EditableProfileImage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Compress image quality
        maxWidth: 800, // Limit max width
        maxHeight: 800, // Limit max height
      );

      if (image != null) {
        // Check file extension
        final String extension = image.path.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png'].contains(extension)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى اختيار صورة بصيغة JPG أو PNG فقط'), backgroundColor: Colors.red),
            );
          }
          return;
        }

        // Check file size (max 2MB)
        final int fileSize = await image.length();
        if (fileSize > 2 * 1024 * 1024) {
          // 2MB in bytes
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('حجم الصورة كبير جداً. يجب أن يكون أقل من 2 ميجابايت'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          _selectedImage = File(image.path);
        });
        widget.onImageSelected(File(image.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('حدث خطأ أثناء اختيار الصورة'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
            child: _selectedImage == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// Registration TextField
class RegistrationTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isNumber;
  final bool isError;
  final TextEditingController controller;

  const RegistrationTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.isNumber = false,
    this.isError = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.grayTextColor, fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: isError ? Colors.red : AppColors.grayColorIcon),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: isError ? Colors.red : AppColors.grayColorIcon),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: isError ? Colors.red : AppColors.primary),
          ),
        ),
      ),
    );
  }
}

// Terms Checkbox
class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TermsCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: value
              ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20)
              : SvgPicture.asset(ImageAssets.cracalWhite, width: 20, height: 20),
        ),
        const SizedBox(width: 10),
        const Text(
          "Agree to the terms and conditions",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// Save Button
class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: const Text(
          "Sign Up",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
