import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive_utils.dart';

/// A responsive text widget that adapts text size based on screen dimensions
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? mobileSmallSize;
  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;
  final double? largeDesktopSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.mobileSmallSize,
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.largeDesktopSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.height,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the font size based on screen size
    final fontSize =
        mobileSmallSize != null ||
                mobileSize != null ||
                tabletSize != null ||
                desktopSize != null ||
                largeDesktopSize != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallSize ?? 14.0,
              mobileValue: mobileSize ?? 16.0,
              tabletValue: tabletSize ?? 18.0,
              desktopValue: desktopSize ?? 20.0,
              largeDesktopValue: largeDesktopSize,
            )
            : style?.fontSize ?? 16.0;

    // Create a responsive text style
    final responsiveStyle = GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight ?? style?.fontWeight ?? FontWeight.normal,
      color: color ?? style?.color,
      letterSpacing: letterSpacing ?? style?.letterSpacing,
      height: height ?? style?.height,
      decoration: decoration ?? style?.decoration,
    );

    return Text(
      text,
      style: style?.copyWith(fontSize: fontSize) ?? responsiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

/// A factory for creating common text styles with responsive sizes
class ResponsiveTextStyles {
  // Headline styles
  static TextStyle headline1(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveHeadlineLarge,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
    );
  }

  static TextStyle headline2(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveHeadlineMedium,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color,
    );
  }

  static TextStyle headline3(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveHeadlineSmall,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color,
    );
  }

  // Body styles
  static TextStyle bodyLarge(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveBodyLarge,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveBodyMedium,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static TextStyle bodySmall(BuildContext context, {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.adaptiveBodySmall,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }
}
