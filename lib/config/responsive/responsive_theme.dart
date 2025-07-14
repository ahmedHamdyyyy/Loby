import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive_utils.dart';

/// A utility class for creating responsive themes
class ResponsiveTheme {
  /// Create a responsive light theme based on screen size
  static ThemeData lightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();

    // Get responsive text sizes
    final textTheme = _getResponsiveTextTheme(context, baseTheme);

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF212121),
      colorScheme: const ColorScheme.light().copyWith(primary: const Color(0xFF212121), secondary: const Color(0xFF757575)),
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme,
      primaryTextTheme: textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: context.adaptiveHeadlineSmall,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF212121),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(
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
              mobileValue: 24.0,
              tabletValue: 32.0,
              desktopValue: 40.0,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.adaptiveValue(
                context: context,
                mobileSmallValue: 4.0,
                mobileValue: 5.0,
                tabletValue: 6.0,
                desktopValue: 8.0,
              ),
            ),
          ),
          textStyle: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: const Color(0xFF212121),
            width: ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: 1.0,
              mobileValue: 1.5,
              tabletValue: 2.0,
              desktopValue: 2.0,
            ),
          ),
          padding: EdgeInsets.symmetric(
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
              mobileValue: 24.0,
              tabletValue: 32.0,
              desktopValue: 40.0,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.adaptiveValue(
                context: context,
                mobileSmallValue: 4.0,
                mobileValue: 5.0,
                tabletValue: 6.0,
                desktopValue: 8.0,
              ),
            ),
          ),
          textStyle: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: 4.0,
              mobileValue: 6.0,
              tabletValue: 8.0,
              desktopValue: 10.0,
            ),
            horizontal: ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: 8.0,
              mobileValue: 12.0,
              tabletValue: 16.0,
              desktopValue: 20.0,
            ),
          ),
          textStyle: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: 4.0,
              mobileValue: 5.0,
              tabletValue: 6.0,
              desktopValue: 8.0,
            ),
          ),
          borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
        ),
        contentPadding: EdgeInsets.symmetric(
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
        ),
        hintStyle: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, color: Colors.grey),
        labelStyle: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, color: Colors.grey),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: 8.0,
              mobileValue: 10.0,
              tabletValue: 12.0,
              desktopValue: 16.0,
            ),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(
          ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 8.0,
            mobileValue: 10.0,
            tabletValue: 12.0,
            desktopValue: 16.0,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        size: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 20.0,
          mobileValue: 24.0,
          tabletValue: 28.0,
          desktopValue: 32.0,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 0.5,
          mobileValue: 0.8,
          tabletValue: 1.0,
          desktopValue: 1.2,
        ),
        space: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 16.0,
          mobileValue: 24.0,
          tabletValue: 32.0,
          desktopValue: 40.0,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 8.0,
        selectedItemColor: const Color(0xFF212121),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 10.0,
            mobileValue: 12.0,
            tabletValue: 14.0,
            desktopValue: 16.0,
          ),
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: ResponsiveUtils.adaptiveValue(
            context: context,
            mobileSmallValue: 10.0,
            mobileValue: 12.0,
            tabletValue: 14.0,
            desktopValue: 16.0,
          ),
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  /// Create a responsive dark theme based on screen size
  static ThemeData darkTheme(BuildContext context) {
    final baseTheme = ThemeData.dark();

    // Get responsive text sizes
    final textTheme = _getResponsiveTextTheme(context, baseTheme);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF212121),
      colorScheme: const ColorScheme.dark().copyWith(primary: const Color(0xFF212121), secondary: const Color(0xFF757575)),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: textTheme,
      primaryTextTheme: textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      // The rest of the theme can be similar to light theme but with dark colors
      // ...
    );
  }

  /// Create a responsive text theme based on screen size
  static TextTheme _getResponsiveTextTheme(BuildContext context, ThemeData baseTheme) {
    // Use Google Fonts for the text theme
    return GoogleFonts.poppinsTextTheme(baseTheme.textTheme).copyWith(
      // Display styles
      displayLarge: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 32.0,
          mobileValue: 36.0,
          tabletValue: 42.0,
          desktopValue: 48.0,
        ),
        fontWeight: FontWeight.w600,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 28.0,
          mobileValue: 32.0,
          tabletValue: 36.0,
          desktopValue: 42.0,
        ),
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 24.0,
          mobileValue: 28.0,
          tabletValue: 32.0,
          desktopValue: 36.0,
        ),
        fontWeight: FontWeight.w600,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.poppins(fontSize: context.adaptiveHeadlineLarge, fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.poppins(fontSize: context.adaptiveHeadlineMedium, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.poppins(fontSize: context.adaptiveHeadlineSmall, fontWeight: FontWeight.w500),

      // Title styles
      titleLarge: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 18.0,
          mobileValue: 20.0,
          tabletValue: 22.0,
          desktopValue: 24.0,
        ),
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 16.0,
          mobileValue: 18.0,
          tabletValue: 20.0,
          desktopValue: 22.0,
        ),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 14.0,
          mobileValue: 16.0,
          tabletValue: 18.0,
          desktopValue: 20.0,
        ),
        fontWeight: FontWeight.w500,
      ),

      // Body styles
      bodyLarge: GoogleFonts.poppins(fontSize: context.adaptiveBodyLarge, fontWeight: FontWeight.normal),
      bodyMedium: GoogleFonts.poppins(fontSize: context.adaptiveBodyMedium, fontWeight: FontWeight.normal),
      bodySmall: GoogleFonts.poppins(fontSize: context.adaptiveBodySmall, fontWeight: FontWeight.normal),

      // Label styles
      labelLarge: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 14.0,
          mobileValue: 16.0,
          tabletValue: 18.0,
          desktopValue: 20.0,
        ),
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 12.0,
          mobileValue: 14.0,
          tabletValue: 16.0,
          desktopValue: 18.0,
        ),
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: ResponsiveUtils.adaptiveValue(
          context: context,
          mobileSmallValue: 10.0,
          mobileValue: 12.0,
          tabletValue: 14.0,
          desktopValue: 16.0,
        ),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
