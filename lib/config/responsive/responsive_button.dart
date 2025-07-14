import 'package:flutter/material.dart';

import 'responsive_text.dart';
import 'responsive_utils.dart';

/// A responsive elevated button that adapts its size based on screen dimensions
class ResponsiveElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final double? mobileSmallWidth;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileSmallBorderRadius;
  final double? mobileBorderRadius;
  final double? tabletBorderRadius;
  final double? desktopBorderRadius;
  final double? textSize;
  final double? elevation;
  final FontWeight? fontWeight;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isFullWidth;

  const ResponsiveElevatedButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.mobileSmallWidth,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileSmallBorderRadius,
    this.mobileBorderRadius,
    this.tabletBorderRadius,
    this.desktopBorderRadius,
    this.textSize,
    this.elevation,
    this.fontWeight,
    this.style,
    this.textStyle,
    this.icon,
    this.isFullWidth = false,
  }) : assert(child != null || text != null, 'Either child or text must be provided');

  @override
  Widget build(BuildContext context) {
    // Determine height based on screen size
    final height = mobileSmallHeight != null || mobileHeight != null || tabletHeight != null || desktopHeight != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallHeight ?? 40.0,
            mobileValue: mobileHeight ?? 48.0,
            tabletValue: tabletHeight ?? 54.0,
            desktopValue: desktopHeight ?? 60.0,
          )
        : null;

    // Determine width based on screen size
    double? width;
    if (isFullWidth) {
      width = double.infinity;
    } else if (mobileSmallWidth != null || mobileWidth != null || tabletWidth != null || desktopWidth != null) {
      width = ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: mobileSmallWidth,
        mobileValue: mobileWidth,
        tabletValue: tabletWidth,
        desktopValue: desktopWidth,
      );
    }

    // Determine border radius based on screen size
    final borderRadius =
        mobileSmallBorderRadius != null ||
            mobileBorderRadius != null ||
            tabletBorderRadius != null ||
            desktopBorderRadius != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallBorderRadius ?? 4.0,
            mobileValue: mobileBorderRadius ?? 5.0,
            tabletValue: tabletBorderRadius ?? 6.0,
            desktopValue: desktopBorderRadius ?? 8.0,
          )
        : 5.0;

    // Create button style
    final buttonStyle =
        style ??
        ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          elevation: elevation,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          minimumSize: Size(width ?? 0, height ?? 0),
        );

    // Build button content
    Widget buttonContent;
    if (child != null) {
      buttonContent = child!;
    } else if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          ResponsiveText(
            text!,
            mobileSmallSize: textSize != null ? textSize! - 2 : 12,
            mobileSize: textSize,
            tabletSize: textSize != null ? textSize! + 2 : 16,
            desktopSize: textSize != null ? textSize! + 4 : 18,
            fontWeight: fontWeight ?? FontWeight.w500,
            style: textStyle,
          ),
        ],
      );
    } else {
      buttonContent = ResponsiveText(
        text!,
        mobileSmallSize: textSize != null ? textSize! - 2 : 12,
        mobileSize: textSize,
        tabletSize: textSize != null ? textSize! + 2 : 16,
        desktopSize: textSize != null ? textSize! + 4 : 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        style: textStyle,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(onPressed: onPressed, style: buttonStyle, child: buttonContent),
    );
  }
}

/// A responsive outlined button that adapts its size based on screen dimensions
class ResponsiveOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final double? mobileSmallWidth;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileSmallBorderRadius;
  final double? mobileBorderRadius;
  final double? tabletBorderRadius;
  final double? desktopBorderRadius;
  final double? textSize;
  final double? borderWidth;
  final FontWeight? fontWeight;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isFullWidth;

  const ResponsiveOutlinedButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.mobileSmallWidth,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileSmallBorderRadius,
    this.mobileBorderRadius,
    this.tabletBorderRadius,
    this.desktopBorderRadius,
    this.textSize,
    this.borderWidth,
    this.fontWeight,
    this.style,
    this.textStyle,
    this.icon,
    this.isFullWidth = false,
  }) : assert(child != null || text != null, 'Either child or text must be provided');

  @override
  Widget build(BuildContext context) {
    // Determine height based on screen size
    final height = mobileSmallHeight != null || mobileHeight != null || tabletHeight != null || desktopHeight != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallHeight ?? 40.0,
            mobileValue: mobileHeight ?? 48.0,
            tabletValue: tabletHeight ?? 54.0,
            desktopValue: desktopHeight ?? 60.0,
          )
        : null;

    // Determine width based on screen size
    double? width;
    if (isFullWidth) {
      width = double.infinity;
    } else if (mobileSmallWidth != null || mobileWidth != null || tabletWidth != null || desktopWidth != null) {
      width = ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: mobileSmallWidth,
        mobileValue: mobileWidth,
        tabletValue: tabletWidth,
        desktopValue: desktopWidth,
      );
    }

    // Determine border radius based on screen size
    final borderRadius =
        mobileSmallBorderRadius != null ||
            mobileBorderRadius != null ||
            tabletBorderRadius != null ||
            desktopBorderRadius != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallBorderRadius ?? 4.0,
            mobileValue: mobileBorderRadius ?? 5.0,
            tabletValue: tabletBorderRadius ?? 6.0,
            desktopValue: desktopBorderRadius ?? 8.0,
          )
        : 5.0;

    // Create button style
    final buttonStyle =
        style ??
        OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          side: BorderSide(width: borderWidth ?? 1.0, color: borderColor ?? Theme.of(context).primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          minimumSize: Size(width ?? 0, height ?? 0),
        );

    // Build button content
    Widget buttonContent;
    if (child != null) {
      buttonContent = child!;
    } else if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          ResponsiveText(
            text!,
            mobileSmallSize: textSize != null ? textSize! - 2 : 12,
            mobileSize: textSize,
            tabletSize: textSize != null ? textSize! + 2 : 16,
            desktopSize: textSize != null ? textSize! + 4 : 18,
            fontWeight: fontWeight ?? FontWeight.w500,
            style: textStyle,
          ),
        ],
      );
    } else {
      buttonContent = ResponsiveText(
        text!,
        mobileSmallSize: textSize != null ? textSize! - 2 : 12,
        mobileSize: textSize,
        tabletSize: textSize != null ? textSize! + 2 : 16,
        desktopSize: textSize != null ? textSize! + 4 : 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        style: textStyle,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(onPressed: onPressed, style: buttonStyle, child: buttonContent),
    );
  }
}

/// A responsive text button that adapts its size based on screen dimensions
class ResponsiveTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? text;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double? textSize;
  final FontWeight? fontWeight;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Widget? icon;

  const ResponsiveTextButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.foregroundColor,
    this.padding,
    this.textSize,
    this.fontWeight,
    this.style,
    this.textStyle,
    this.icon,
  }) : assert(child != null || text != null, 'Either child or text must be provided');

  @override
  Widget build(BuildContext context) {
    // Create button style
    final buttonStyle = style ?? TextButton.styleFrom(foregroundColor: foregroundColor, padding: padding);

    // Build button content
    Widget buttonContent;
    if (child != null) {
      buttonContent = child!;
    } else if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          ResponsiveText(
            text!,
            mobileSmallSize: textSize != null ? textSize! - 2 : 12,
            mobileSize: textSize,
            tabletSize: textSize != null ? textSize! + 2 : 16,
            desktopSize: textSize != null ? textSize! + 4 : 18,
            fontWeight: fontWeight ?? FontWeight.w500,
            style: textStyle,
          ),
        ],
      );
    } else {
      buttonContent = ResponsiveText(
        text!,
        mobileSmallSize: textSize != null ? textSize! - 2 : 12,
        mobileSize: textSize,
        tabletSize: textSize != null ? textSize! + 2 : 16,
        desktopSize: textSize != null ? textSize! + 4 : 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        style: textStyle,
      );
    }

    return TextButton(onPressed: onPressed, style: buttonStyle, child: buttonContent);
  }
}

/// A responsive icon button that adapts its size based on screen dimensions
class ResponsiveIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final double? mobileSmallSize;
  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? splashRadius;
  final String? tooltip;
  final bool isEnabled;

  const ResponsiveIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.mobileSmallSize,
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.color,
    this.padding,
    this.backgroundColor,
    this.splashRadius,
    this.tooltip,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine icon size based on screen size
    final size = mobileSmallSize != null || mobileSize != null || tabletSize != null || desktopSize != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallSize ?? 20.0,
            mobileValue: mobileSize ?? 24.0,
            tabletValue: tabletSize ?? 28.0,
            desktopValue: desktopSize ?? 32.0,
          )
        : 24.0;

    // Determine splash radius based on screen size
    final effectiveSplashRadius = splashRadius ?? (size / 2);

    // Create icon button
    final iconButton = IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon: icon,
      iconSize: size,
      color: color,
      padding: padding ?? const EdgeInsets.all(8),
      splashRadius: effectiveSplashRadius,
      tooltip: tooltip,
      style: IconButton.styleFrom(backgroundColor: backgroundColor),
    );

    // Wrap with tooltip if provided
    return tooltip != null ? Tooltip(message: tooltip!, child: iconButton) : iconButton;
  }
}
