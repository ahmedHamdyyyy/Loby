import 'package:flutter/material.dart';

/// A utility class for responsive design
class ResponsiveUtils {
  // Device breakpoints
  static const double mobileSmallBreakpoint = 320.0;
  static const double mobileBreakpoint = 480.0;
  static const double tabletBreakpoint = 768.0;
  static const double desktopBreakpoint = 1024.0;
  static const double largeDesktopBreakpoint = 1440.0;

  // Device types
  static bool isMobileSmall(BuildContext context) => MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint && MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint && MediaQuery.of(context).size.width < desktopBreakpoint;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= desktopBreakpoint;

  // Orientation helpers
  static bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;

  // Screen dimensions
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  static double screenWidth(BuildContext context) => screenSize(context).width;
  static double screenHeight(BuildContext context) => screenSize(context).height;

  // Safe area dimensions
  static EdgeInsets safeArea(BuildContext context) => MediaQuery.of(context).padding;

  // Device type string (for debugging)
  static String deviceType(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return 'Mobile Small';
    if (width < tabletBreakpoint) return 'Mobile';
    if (width < desktopBreakpoint) return 'Tablet';
    if (width < largeDesktopBreakpoint) return 'Desktop';
    return 'Large Desktop';
  }

  // Get a value based on screen size
  static T adaptiveValue<T>({
    required BuildContext context,
    required T mobileSmallValue,
    required T mobileValue,
    required T tabletValue,
    required T desktopValue,
    T? largeDesktopValue,
  }) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) return mobileSmallValue;
    if (width < tabletBreakpoint) return mobileValue;
    if (width < desktopBreakpoint) return tabletValue;
    if (width < largeDesktopBreakpoint || largeDesktopValue == null) return desktopValue;
    return largeDesktopValue;
  }

  // Get proportional value based on screen width
  static double proportionalWidth(BuildContext context, double percentage) => screenWidth(context) * percentage;

  // Get proportional value based on screen height
  static double proportionalHeight(BuildContext context, double percentage) => screenHeight(context) * percentage;
}

/// Extension on BuildContext for easy access to responsive utilities
extension ResponsiveContext on BuildContext {
  // Screen dimensions
  Size get screenSize => ResponsiveUtils.screenSize(this);
  double get screenWidth => ResponsiveUtils.screenWidth(this);
  double get screenHeight => ResponsiveUtils.screenHeight(this);

  // Device types
  bool get isMobileSmall => ResponsiveUtils.isMobileSmall(this);
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);

  // Orientation
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  bool get isPortrait => ResponsiveUtils.isPortrait(this);

  // Adaptive values
  EdgeInsets get safeArea => ResponsiveUtils.safeArea(this);
  String get deviceType => ResponsiveUtils.deviceType(this);

  // Helper methods
  double proportionalWidth(double percentage) => ResponsiveUtils.proportionalWidth(this, percentage);

  double proportionalHeight(double percentage) => ResponsiveUtils.proportionalHeight(this, percentage);

  // Adaptive padding values
  EdgeInsets get adaptivePadding => EdgeInsets.symmetric(
    horizontal: ResponsiveUtils.adaptiveValue(
      context: this,
      mobileSmallValue: 12.0,
      mobileValue: 16.0,
      tabletValue: 24.0,
      desktopValue: 32.0,
    ),
    vertical: ResponsiveUtils.adaptiveValue(
      context: this,
      mobileSmallValue: 8.0,
      mobileValue: 12.0,
      tabletValue: 16.0,
      desktopValue: 24.0,
    ),
  );

  // Adaptive text sizes
  double get adaptiveHeadlineLarge => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 24.0,
    mobileValue: 28.0,
    tabletValue: 32.0,
    desktopValue: 36.0,
  );

  double get adaptiveHeadlineMedium => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 20.0,
    mobileValue: 24.0,
    tabletValue: 28.0,
    desktopValue: 32.0,
  );

  double get adaptiveHeadlineSmall => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 18.0,
    mobileValue: 20.0,
    tabletValue: 24.0,
    desktopValue: 28.0,
  );

  double get adaptiveBodyLarge => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 14.0,
    mobileValue: 16.0,
    tabletValue: 18.0,
    desktopValue: 20.0,
  );

  double get adaptiveBodyMedium => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 12.0,
    mobileValue: 14.0,
    tabletValue: 16.0,
    desktopValue: 18.0,
  );

  double get adaptiveBodySmall => ResponsiveUtils.adaptiveValue(
    context: this,
    mobileSmallValue: 10.0,
    mobileValue: 12.0,
    tabletValue: 14.0,
    desktopValue: 16.0,
  );
}

/// Responsive widget that adapts based on screen size
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? mobileSmall;
  final Widget? largeDesktop;

  const Responsive({super.key, required this.mobile, this.tablet, this.desktop, this.mobileSmall, this.largeDesktop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Large desktop layout
    if (width >= ResponsiveUtils.largeDesktopBreakpoint && largeDesktop != null) {
      return largeDesktop!;
    }

    // Desktop layout
    if (width >= ResponsiveUtils.desktopBreakpoint) {
      return desktop ?? tablet ?? mobile;
    }

    // Tablet layout
    if (width >= ResponsiveUtils.tabletBreakpoint) {
      return tablet ?? mobile;
    }

    // Mobile small layout
    if (width < ResponsiveUtils.mobileBreakpoint && mobileSmall != null) {
      return mobileSmall!;
    }

    // Mobile layout
    return mobile;
  }
}

/// A responsive padding widget that adapts based on screen size
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobileSmallPadding;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobileSmallPadding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: mobileSmallPadding ?? const EdgeInsets.all(8.0),
        mobileValue: mobilePadding ?? const EdgeInsets.all(16.0),
        tabletValue: tabletPadding ?? const EdgeInsets.all(24.0),
        desktopValue: desktopPadding ?? const EdgeInsets.all(32.0),
      ),
      child: child,
    );
  }
}

/// A responsive sized box that adapts height and width based on screen size
class ResponsiveSizedBox extends StatelessWidget {
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final double? mobileSmallWidth;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;

  const ResponsiveSizedBox({
    super.key,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.mobileSmallWidth,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
  });

  @override
  Widget build(BuildContext context) {
    final height =
        mobileSmallHeight != null || mobileHeight != null || tabletHeight != null || desktopHeight != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallHeight ?? 0.0,
              mobileValue: mobileHeight ?? 0.0,
              tabletValue: tabletHeight ?? 0.0,
              desktopValue: desktopHeight ?? 0.0,
            )
            : null;

    final width =
        mobileSmallWidth != null || mobileWidth != null || tabletWidth != null || desktopWidth != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallWidth ?? 0.0,
              mobileValue: mobileWidth ?? 0.0,
              tabletValue: tabletWidth ?? 0.0,
              desktopValue: desktopWidth ?? 0.0,
            )
            : null;

    return SizedBox(height: height, width: width);
  }
}
