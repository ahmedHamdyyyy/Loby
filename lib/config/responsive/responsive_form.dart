import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'responsive_text.dart';
import 'responsive_utils.dart';

/// A responsive text field that adapts its size based on screen dimensions
class ResponsiveTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final EdgeInsetsGeometry? contentPadding;
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool filled;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final double? mobileSmallBorderRadius;
  final double? mobileBorderRadius;
  final double? tabletBorderRadius;
  final double? desktopBorderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;

  const ResponsiveTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.contentPadding,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.fillColor,
    this.filled = false,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.mobileSmallBorderRadius,
    this.mobileBorderRadius,
    this.tabletBorderRadius,
    this.desktopBorderRadius,
    this.inputFormatters,
    this.autoFocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    // Determine height based on screen size (if multi-line, let it size itself)
    final height = maxLines == 1 && !expands
        ? (mobileSmallHeight != null || mobileHeight != null || tabletHeight != null || desktopHeight != null
              ? ResponsiveUtils.adaptiveValue(
                  context: context,
                  mobileSmallValue: mobileSmallHeight ?? 40.0,
                  mobileValue: mobileHeight ?? 48.0,
                  tabletValue: tabletHeight ?? 54.0,
                  desktopValue: desktopHeight ?? 60.0,
                )
              : null)
        : null;

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

    // Determine content padding based on screen size
    final adaptiveContentPadding =
        contentPadding ??
        ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          mobileValue: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          tabletValue: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          desktopValue: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        );

    // Determine text style based on screen size
    final textStyle =
        style ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
        );

    // Determine hint style based on screen size
    final textHintStyle =
        hintStyle ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
          color: Colors.grey,
        );

    // Determine label style based on screen size
    final textLabelStyle =
        labelStyle ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
        );

    // Create the input border
    final inputBorder =
        border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        );

    // Create the focused input border
    final focusedInputBorder =
        focusedBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        );

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: adaptiveContentPadding,
          filled: filled,
          fillColor: fillColor,
          hintStyle: textHintStyle,
          labelStyle: textLabelStyle,
          border: inputBorder,
          focusedBorder: focusedInputBorder,
          enabledBorder: enabledBorder ?? inputBorder,
          errorBorder: errorBorder,
          disabledBorder: disabledBorder,
          focusedErrorBorder: focusedErrorBorder,
        ),
        style: textStyle,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly,
        focusNode: focusNode,
        textInputAction: textInputAction,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        expands: expands,
        inputFormatters: inputFormatters,
        autofocus: autoFocus,
        textCapitalization: textCapitalization,
        textAlign: textAlign,
      ),
    );
  }
}

/// A responsive dropdown button that adapts its size based on screen dimensions
class ResponsiveDropdownButton<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? hint;
  final Widget? icon;
  final bool isExpanded;
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final double? mobileSmallBorderRadius;
  final double? mobileBorderRadius;
  final double? tabletBorderRadius;
  final double? desktopBorderRadius;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? dropdownColor;
  final Color? focusColor;
  final Color? borderColor;

  const ResponsiveDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.icon,
    this.isExpanded = false,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.mobileSmallBorderRadius,
    this.mobileBorderRadius,
    this.tabletBorderRadius,
    this.desktopBorderRadius,
    this.style,
    this.hintStyle,
    this.dropdownColor,
    this.focusColor,
    this.borderColor,
  });

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

    // Determine text style based on screen size
    final textStyle =
        style ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
        );

    // Determine hint style based on screen size
    final textHintStyle =
        hintStyle ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
          color: Colors.grey,
        );

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? Colors.grey),
      ),
      child: DropdownButton<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        hint: hint != null ? Text(hint!, style: textHintStyle) : null,
        icon: icon ?? const Icon(Icons.arrow_drop_down),
        isExpanded: isExpanded,
        style: textStyle,
        dropdownColor: dropdownColor,
        focusColor: focusColor,
        underline: Container(), // Remove the default underline
      ),
    );
  }
}

/// A responsive checkbox that adapts its size based on screen dimensions
class ResponsiveCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final Color? focusColor;
  final double? mobileSmallSize;
  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;
  final bool isEnabled;
  final String? label;
  final TextStyle? labelStyle;

  const ResponsiveCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.mobileSmallSize,
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.isEnabled = true,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Determine size based on screen size
    final size = mobileSmallSize != null || mobileSize != null || tabletSize != null || desktopSize != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallSize ?? 18.0,
            mobileValue: mobileSize ?? 20.0,
            tabletValue: tabletSize ?? 24.0,
            desktopValue: desktopSize ?? 28.0,
          )
        : null;

    // Determine text style based on screen size
    final textStyle =
        labelStyle ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
        );

    final checkbox = Transform.scale(
      scale: size != null ? size / 24.0 : 1.0, // Size adjustment
      child: Checkbox(
        value: value,
        onChanged: isEnabled ? onChanged : null,
        activeColor: activeColor,
        checkColor: checkColor,
        focusColor: focusColor,
      ),
    );

    // Return just the checkbox if no label
    if (label == null) {
      return checkbox;
    }

    // Return checkbox with label
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        checkbox,
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: isEnabled ? () => onChanged?.call(!value) : null,
            child: ResponsiveText(label!, style: textStyle),
          ),
        ),
      ],
    );
  }
}

/// A responsive radio button that adapts its size based on screen dimensions
class ResponsiveRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final Color? focusColor;
  final double? mobileSmallSize;
  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;
  final bool isEnabled;
  final String? label;
  final TextStyle? labelStyle;

  const ResponsiveRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.activeColor,
    this.focusColor,
    this.mobileSmallSize,
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
    this.isEnabled = true,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Determine size based on screen size
    final size = mobileSmallSize != null || mobileSize != null || tabletSize != null || desktopSize != null
        ? ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: mobileSmallSize ?? 18.0,
            mobileValue: mobileSize ?? 20.0,
            tabletValue: tabletSize ?? 24.0,
            desktopValue: desktopSize ?? 28.0,
          )
        : null;

    // Determine text style based on screen size
    final textStyle =
        labelStyle ??
        TextStyle(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 14.0,
            mobileValue: 16.0,
            tabletValue: 18.0,
            desktopValue: 20.0,
          ),
        );

    final radio = Transform.scale(
      scale: size != null ? size / 24.0 : 1.0, // Size adjustment
      child: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: isEnabled ? onChanged : null,
        activeColor: activeColor,
        focusColor: focusColor,
      ),
    );

    // Return just the radio if no label
    if (label == null) {
      return radio;
    }

    // Return radio with label
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        radio,
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: isEnabled ? () => onChanged?.call(value) : null,
            child: ResponsiveText(label!, style: textStyle),
          ),
        ),
      ],
    );
  }
}
