import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../core/localization/l10n_ext.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.imagePath, required this.text, required this.onPressed});
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: const BorderSide(color: AppColors.primary),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Image.asset(imagePath, width: 22, height: 22),
              const SizedBox(width: 20),
              Text(text, style: const TextStyle(fontSize: 16, color: Color(0xFF414141))),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------ Guest Login Button Widget ------------------------

class GuestLoginButton extends StatefulWidget {
  final VoidCallback onTap;
  const GuestLoginButton({super.key, required this.onTap});
  @override
  State<GuestLoginButton> createState() => _GuestLoginButtonState();
}

class _GuestLoginButtonState extends State<GuestLoginButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isHovered = true;
        setState(() => _animationController.forward());
      },
      onExit: (_) {
        _isHovered = false;
        setState(() => _animationController.reverse());
      },
      child: GestureDetector(
        onTap: () => _animationController.forward().then((_) => _animationController.reverse().then((_) => widget.onTap())),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withAlpha(200), AppColors.primary.withAlpha(225)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(75),
                      blurRadius: _isHovered ? 12 : 5,
                      spreadRadius: _isHovered ? 2 : 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_outline_rounded, color: Colors.white, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      context.l10n.continueAsGuest,
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onContinue,
    required this.onGoogleContinue,
    required this.onFacebookContinue,
    required this.onGuestLogin,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onCreateAccount,
  });
  final VoidCallback onContinue, onGoogleContinue, onFacebookContinue, onGuestLogin, onTogglePassword, onCreateAccount;
  final TextEditingController emailController, passwordController;
  final bool obscurePassword;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? screenWidth * 0.2 : 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: 'app_logo',
                  child: Image.asset('assets/images/logo1.png', color: AppColors.primary, width: 175, height: 175),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.welcomeBack,
                style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 335,
                child: Text(
                  context.l10n.loginIntro,
                  style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    hintText: context.l10n.emailHint,
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFFCBCBCB),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryColor),
                      onPressed: onTogglePassword,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    hintText: context.l10n.passwordHint,
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFFCBCBCB),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onContinue,
                  child: Text(
                    context.l10n.signIn,
                    style: GoogleFonts.poppins(color: AppColors.primaryWhite, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onCreateAccount,
                  child: Text(
                    context.l10n.createAccount,
                    style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Center(child: Text(context.l10n.orContinueWith, style: const TextStyle(color: Colors.black54, fontSize: 16))),
              // const SizedBox(height: 10),
              // SocialButton(
              //   onPressed: onGoogleContinue,
              //   imagePath: 'assets/images/google_flag.png',
              //   text: context.l10n.continueWithGoogle,
              // ),
              // const SizedBox(height: 10),
              // SocialButton(
              //   onPressed: onFacebookContinue,
              //   imagePath: 'assets/images/facebook_flag.png',
              //   text: context.l10n.continueWithFacebook,
              // ),
              // const SizedBox(height: 35),
              // Center(child: GuestLoginButton(onTap: onGuestLogin)),
            ],
          ),
        ),
      ),
    );
  }
}
