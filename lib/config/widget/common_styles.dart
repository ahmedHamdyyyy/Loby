import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/colors.dart';

/// Common text styles for consistent text across the application
class TextStyles {
  // Title styles
  static TextStyle title({double size = 16, FontWeight weight = FontWeight.w600, Color color = AppColors.primaryTextColor}) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
  }

  // Subtitle styles
  static TextStyle subtitle({double size = 14, FontWeight weight = FontWeight.w500, Color color = AppColors.grayTextColor}) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
  }

  // Body text styles
  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.accountTextColor,
    double height = 1.5,
  }) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color, height: height);
  }

  // Button text styles
  static TextStyle button({double size = 16, FontWeight weight = FontWeight.w500, Color color = AppColors.whiteColor}) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
  }
}

/// Common container decorations for consistent UI components
class ContainerStyles {
  // Card decoration
  static BoxDecoration card({
    Color? color,
    double radius = 12.0,
    Color borderColor = Colors.transparent,
    double borderWidth = 0,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: shadows,
    );
  }

  // Form field decoration
  static BoxDecoration formField({Color borderColor = AppColors.lightGray, double radius = 10.0, double borderWidth = 1.5}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }

  // Profile card decoration
  static BoxDecoration profileCard({Color borderColor = Colors.grey, double radius = 15.0}) {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor.withAlpha(50), width: 1),
      boxShadow: [BoxShadow(color: Colors.grey.withAlpha(25), blurRadius: 5, spreadRadius: 1)],
    );
  }
}

/// Common padding values for consistent spacing
class Paddings {
  static const EdgeInsets standard = EdgeInsets.all(20);
  static const EdgeInsets small = EdgeInsets.all(10);
  static const EdgeInsets large = EdgeInsets.all(30);
  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets vertical = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets content = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
}

/// Common button styles for consistency
class ButtonStyles {
  static ButtonStyle primary({double radius = 10.0, Color backgroundColor = AppColors.primaryColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      padding: Paddings.vertical,
    );
  }

  static ButtonStyle outlined({
    double radius = 10.0,
    Color borderColor = AppColors.primaryColor,
    Color textColor = AppColors.primaryTextColor,
  }) {
    return OutlinedButton.styleFrom(
      side: BorderSide(color: borderColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      padding: Paddings.vertical,
      foregroundColor: textColor,
    );
  }
}

/// Common UI components
class CommonWidgets {
  // Standard back button with title
  static Widget headerWithBack({
    required BuildContext context,
    required String title,
    Color iconColor = AppColors.grayColorIcon,
    Color textColor = AppColors.grayTextColor,
  }) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 24),
          color: iconColor,
        ),
        Text(title, style: TextStyles.subtitle(color: textColor)),
      ],
    );
  }

  // Standard page title
  static Widget pageTitle({
    required String title,
    Color color = AppColors.primaryTextColor,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Padding(
      padding: Paddings.content,
      child: Text(title, style: TextStyles.title(size: fontSize, weight: fontWeight, color: color)),
    );
  }

  // Standard divider
  static Widget divider({double height = 1, Color color = AppColors.lightGray}) {
    return Padding(padding: Paddings.horizontal, child: Divider(height: height, color: color));
  }
}
