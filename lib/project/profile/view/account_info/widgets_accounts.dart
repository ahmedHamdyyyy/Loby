import 'package:Luby/project/profile/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/common_styles.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../../../locator.dart';
import '../../../../core/utils/utile.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../auth/view/Screen/sign_in.dart';
import '../about_loby/about_loby_view.dart';
import '../contact_us/contact_us_view.dart';
import '../language/language_view.dart';
import '../privacy/privacy_view.dart';
import '../terms_condition/terma_conditions_view.dart';
import 'account_after_save.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback? onEdit;

  const CustomAppBar({super.key, required this.title, required this.onBack, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon), onPressed: onBack),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.grayTextColor,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: false,
      actions: [if (onEdit != null) IconButton(icon: SvgPicture.asset(ImageAssets.editIcon), onPressed: onEdit)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: 50, backgroundImage: AssetImage(ImageAssets.profileImage));
  }
}

class ProfileNameAndEmail extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileNameAndEmail({super.key, required this.firstName, required this.lastName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$firstName $lastName",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400)),
      ],
    );
  }
}

class ProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isEditing;

  const ProfileForm({
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
        ProfileTextField(controller: firstNameController, isEnabled: isEditing),
        ProfileTextField(controller: lastNameController, isEnabled: isEditing),
        ProfileTextField(controller: phoneController, isEnabled: isEditing),
        ProfileTextField(controller: emailController, isEnabled: isEditing),
        ProfileTextField(controller: passwordController, isEnabled: isEditing, isPassword: true),
      ],
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final bool isPassword;

  const ProfileTextField({super.key, required this.controller, required this.isEnabled, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 6),
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
    );
  }
}

class NavigationHeader extends StatelessWidget {
  final String title;

  const NavigationHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.grayTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class InfoHeader extends StatelessWidget {
  final String title;

  const InfoHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class ProfileImageWithEdit extends StatelessWidget {
  const ProfileImageWithEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Positioned(bottom: 5, right: 5, child: SvgPicture.asset('assets/svg/edit.svg', width: 24, height: 24)),
      ],
    );
  }
}

class UserNameAndEmail extends StatelessWidget {
  final String name;
  final String email;

  const UserNameAndEmail({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.accountTextColor,
          ),
        ),
        Text(
          email,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class AccountFormFields extends StatelessWidget {
  final VoidCallback onToggleTerms;
  final bool isTermsAccepted;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const AccountFormFields({
    super.key,
    required this.onToggleTerms,
    required this.isTermsAccepted,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormTextField(hintText: "First Name", isError: false),
        const FormTextField(hintText: "Last Name"),
        const FormTextField(hintText: "0123456789", isNumber: true),
        const FormTextField(hintText: "E-Mail"),
        FormTextField(
          hintText: "Password",
          isPassword: true,
          isVisible: isPasswordVisible,
          onToggleVisibility: onTogglePasswordVisibility,
        ),
        FormTextField(
          hintText: "Confirm Password",
          isPassword: true,
          isVisible: isConfirmPasswordVisible,
          onToggleVisibility: onToggleConfirmPasswordVisibility,
        ),
        const SizedBox(height: 10),
        TermsAgreementCheckbox(isChecked: isTermsAccepted, onToggle: onToggleTerms),
      ],
    );
  }
}

class FormTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isNumber;
  final bool isError;
  final bool? isVisible;
  final VoidCallback? onToggleVisibility;

  const FormTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.isNumber = false,
    this.isError = false,
    this.isVisible,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isError ? AppColors.primaryColor : Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: isPassword ? !(isVisible ?? false) : false,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(isVisible ?? false ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                    onPressed: onToggleVisibility,
                  )
                  : null,
        ),
      ),
    );
  }
}

class TermsAgreementCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onToggle;

  const TermsAgreementCheckbox({super.key, required this.isChecked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onToggle,
          child:
              isChecked
                  ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20)
                  : SvgPicture.asset(ImageAssets.cracalWhite, width: 20, height: 20),
        ),
        const SizedBox(width: 10),
        Text(
          context.l10n.agreeToTerms,
          style: const TextStyle(
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

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

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
        child: Text(
          context.l10n.save,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: Paddings.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(alignment: Alignment.centerLeft, child: Text(context.l10n.account, style: TextStyles.subtitle())),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.signoutStatus == Status.loading) {
              Utils.loadingDialog(context);
            } else if (state.signoutStatus == Status.success) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false,
              );
            } else if (state.signoutStatus == Status.error) {
              Navigator.pop(context);
              Utils.errorDialog(context, state.msg);
            }
          },
          builder: (context, state) {
            return IconButton(onPressed: getIt<AuthCubit>().signout, icon: const Icon(Icons.logout));
          },
        ),
      ],
    ),
  );
}

class AccountProfileCard extends StatelessWidget {
  const AccountProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Container(
          margin: Paddings.standard,
          decoration: ContainerStyles.profileCard(),
          child: Column(
            children: [
              SizedBox(height: 20),
              ProfileAvatar(image: state.user.profilePicture),
              SizedBox(height: 10),
              ProfileInfo(name: state.user.firstName, email: state.user.email),
              SizedBox(height: 20),
              MenuItems(),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String image;
  const ProfileAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black,
            child: Image.asset("assets/images/logo1.png", width: 50, height: 50),
          );
        },
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String name;
  final String email;

  const ProfileInfo({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: TextStyles.body(color: AppColors.accountTextColor, size: 16)),
        Text(email, style: TextStyles.body(color: Colors.grey, size: 14)),
      ],
    );
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItemWithArrow(icon: ImageAssets.userIcon, title: context.l10n.yourAccount, screen: const AccountScreen()),
        /*   MenuItemWithArrow(
          icon: ImageAssets.cardIcon,
          title: "Bank Cards",
          screen: const BankCardScreen(),
        ), */
        // MenuItemWithArrow(icon: ImageAssets.walletIcon, title: context.l10n.wallet, screen: const WalletScreenVendor()),
        MenuItemWithArrow(icon: ImageAssets.languageIcon, title: context.l10n.language, screen: const LanguageViewVendor()),
        // MenuItemWithArrow(icon: ImageAssets.userIcon, title: context.l10n.hostWithUs, screen: const HostWithUsViewVendor()),
        MenuItemWithArrow(icon: ImageAssets.messageIcon, title: context.l10n.aboutLoby, screen: const AboutLobyViewVendor()),
        MenuItemWithArrow(
          icon: ImageAssets.tarmsAndConditionsIcon,
          title: context.l10n.termsAndConditions,
          screen: const TermaConditionsViewVendor(),
        ),
        MenuItemWithArrow(
          icon: ImageAssets.securityIcon,
          title: context.l10n.privacyPolicy,
          screen: const PrivacyViewVendor(),
        ),
        MenuItemWithArrow(icon: ImageAssets.chat2, title: context.l10n.contactUs, screen: const ContactUsViewVendor()),
        MenuItemSimple(icon: ImageAssets.rate, title: context.l10n.rateApp, screen: const RateLubycreen()),
        MenuItemSimple(icon: ImageAssets.invite, title: context.l10n.inviteFriends, screen: const InviteFriendsScreen()),
        //MenuItemSimple(icon: ImageAssets.logout, title: "Log out", screen: SignInScreen()),
      ],
    );
  }
}

class MenuItemWithArrow extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? screen;

  const MenuItemWithArrow({super.key, required this.icon, required this.title, this.screen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 24, height: 24),
      title: Text(title, style: TextStyles.body(color: AppColors.accountTextColor, size: 16)),
      trailing: SvgPicture.asset(ImageAssets.arrowDown, height: 24, width: 24),
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
        }
      },
    );
  }
}

class MenuItemSimple extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? screen;

  const MenuItemSimple({super.key, required this.icon, required this.title, this.screen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(title, style: TextStyles.body(color: AppColors.accountTextColor, size: 14)),
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
        }
      },
    );
  }
}

class RateLubycreen extends StatelessWidget {
  const RateLubycreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(title: context.l10n.rateApp);
  }
}

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(title: context.l10n.inviteFriends);
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, title, AppColors.grayTextColor),
      body: Center(child: Text(context.l10n.comingSoon, style: TextStyles.body(size: 20, color: Colors.grey))),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteAccountDialog({super.key, required this.onConfirm, required this.onCancel});

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
            const DeleteDialogHeader(),
            const SizedBox(height: 25),
            DeleteDialogActions(onConfirm: onConfirm, onCancel: onCancel),
          ],
        ),
      ),
    );
  }
}

class AccountInfoHeader extends StatelessWidget {
  const AccountInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon)),
            const SizedBox(width: 8),
            Text(
              context.l10n.accountInfo,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          context.l10n.pleaseCompleteInformation,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class DeleteDialogHeader extends StatelessWidget {
  const DeleteDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${context.l10n.deleteAccount}",
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1.2, width: 120, color: AppColors.primaryColor),
        Text(
          context.l10n.areYouSureDeleteAccount,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.secondTextColor,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}

class DeleteDialogActions extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteDialogActions({super.key, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              context.l10n.yes,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16, fontFamily: 'Poppins'),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              context.l10n.commonCancel,
              style: const TextStyle(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void navigateToAccountAfterSave(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountScreen()));
}
