import 'package:flutter/material.dart';
import 'responsive_utils.dart';

/// A utility class for app-wide dimensions and spacing
class AppDimensions {
  // Singleton instance
  static final AppDimensions _instance = AppDimensions._internal();
  factory AppDimensions() => _instance;
  AppDimensions._internal();

  // Screen padding
  EdgeInsets screenPadding(BuildContext context) => EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 16.0,
          mobileValue: 20.0,
          tabletValue: 32.0,
          desktopValue: 48.0,
        ),
      );

  // Card padding
  EdgeInsets cardPadding(BuildContext context) => EdgeInsets.all(
        ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 12.0,
          mobileValue: 16.0,
          tabletValue: 20.0,
          desktopValue: 24.0,
        ),
      );

  // Button padding
  EdgeInsets buttonPadding(BuildContext context) => EdgeInsets.symmetric(
        vertical: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 8.0,
          mobileValue: 12.0,
          tabletValue: 16.0,
          desktopValue: 20.0,
        ),
        horizontal: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 16.0,
          mobileValue: 20.0,
          tabletValue: 24.0,
          desktopValue: 32.0,
        ),
      );

  // Input field padding
  EdgeInsets inputFieldPadding(BuildContext context) => EdgeInsets.symmetric(
        vertical: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 8.0,
          mobileValue: 12.0,
          tabletValue: 16.0,
          desktopValue: 20.0,
        ),
        horizontal: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 12.0,
          mobileValue: 16.0,
          tabletValue: 20.0,
          desktopValue: 24.0,
        ),
      );

  // Section spacing
  double sectionSpacing(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 16.0,
        mobileValue: 24.0,
        tabletValue: 32.0,
        desktopValue: 48.0,
      );

  // Component spacing
  double componentSpacing(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 8.0,
        mobileValue: 12.0,
        tabletValue: 16.0,
        desktopValue: 24.0,
      );

  // Item spacing
  double itemSpacing(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 4.0,
        mobileValue: 8.0,
        tabletValue: 12.0,
        desktopValue: 16.0,
      );

  // Border radius
  double borderRadius(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 4.0,
        mobileValue: 8.0,
        tabletValue: 12.0,
        desktopValue: 16.0,
      );

  // Card border radius
  double cardBorderRadius(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 8.0,
        mobileValue: 12.0,
        tabletValue: 16.0,
        desktopValue: 20.0,
      );

  // Button height
  double buttonHeight(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 40.0,
        mobileValue: 48.0,
        tabletValue: 56.0,
        desktopValue: 64.0,
      );

  // Input field height
  double inputFieldHeight(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 40.0,
        mobileValue: 48.0,
        tabletValue: 56.0,
        desktopValue: 64.0,
      );

  // Icon size
  double iconSize(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 16.0,
        mobileValue: 20.0,
        tabletValue: 24.0,
        desktopValue: 28.0,
      );

  // Avatar size
  double avatarSize(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 32.0,
        mobileValue: 40.0,
        tabletValue: 48.0,
        desktopValue: 56.0,
      );

  // Thumbnail size
  double thumbnailSize(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 64.0,
        mobileValue: 80.0,
        tabletValue: 96.0,
        desktopValue: 112.0,
      );

  // Max content width (for tablets/desktops to avoid stretching too wide)
  double maxContentWidth(BuildContext context) => ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: double.infinity,
        mobileValue: double.infinity,
        tabletValue: 680.0,
        desktopValue: 960.0,
      );

  // Grid item width
  double gridItemWidth(BuildContext context, {int columns = 2}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final adaptiveColumns = ResponsiveUtils.adaptiveValue(
      context: context,
      mobileSmallValue: columns > 2 ? 1 : columns,
      mobileValue: columns > 3 ? 2 : columns,
      tabletValue: columns > 4 ? 3 : columns,
      desktopValue: columns,
    );
    
    final padding = screenPadding(context).horizontal / 2;
    final spacing = itemSpacing(context) * (adaptiveColumns - 1);
    
    return (screenWidth - (padding * 2) - spacing) / adaptiveColumns;
  }

  // Grid item height for maintaining aspect ratio
  double gridItemHeight(BuildContext context, {int columns = 2, double aspectRatio = 1.0}) {
    return gridItemWidth(context, columns: columns) / aspectRatio;
  }
}

// Extension for easier access
extension AppDimensionsExtension on BuildContext {
  AppDimensions get dimensions => AppDimensions();
  
  // Direct access to common dimensions
  EdgeInsets get screenPadding => dimensions.screenPadding(this);
  EdgeInsets get cardPadding => dimensions.cardPadding(this);
  EdgeInsets get buttonPadding => dimensions.buttonPadding(this);
  EdgeInsets get inputFieldPadding => dimensions.inputFieldPadding(this);
  
  double get sectionSpacing => dimensions.sectionSpacing(this);
  double get componentSpacing => dimensions.componentSpacing(this);
  double get itemSpacing => dimensions.itemSpacing(this);
  
  double get borderRadius => dimensions.borderRadius(this);
  double get cardBorderRadius => dimensions.cardBorderRadius(this);
  
  double get buttonHeight => dimensions.buttonHeight(this);
  double get inputFieldHeight => dimensions.inputFieldHeight(this);
  
  double get iconSize => dimensions.iconSize(this);
  double get avatarSize => dimensions.avatarSize(this);
  double get thumbnailSize => dimensions.thumbnailSize(this);
  
  double get maxContentWidth => dimensions.maxContentWidth(this);
} 