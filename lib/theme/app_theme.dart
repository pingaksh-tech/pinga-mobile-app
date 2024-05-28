import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../exports.dart';

class AppTheme {
  static String fontFamilyName = 'DmSans';

  static ThemeData lightMode(BuildContext context, {Color? kPrimaryColor, Color? kSecondaryColor, Color? kBackgroundColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: const Color(0xffffffff),
      shadowColor: const Color(0xFFdedcdc),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor?.withOpacity(0.2),
      hoverColor: kPrimaryColor?.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFFFFFFFF),
      disabledColor: const Color(0xFFD3D9DD),
      textTheme: buildTextTheme(base: base.textTheme, fontColor: AppColors.font, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, fontColor: AppColors.font, myFontFamily: fontFamily),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.primary)),
      dividerColor: kSecondaryColor?.withOpacity(0.5),
      dividerTheme: DividerThemeData(color: kSecondaryColor?.withOpacity(0.15)),
      // Widgets Theme
      appBarTheme: AppBarTheme(
        color: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FCFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor ?? const Color(0xFF000000), width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        error: errorColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        surface: AppColors.background,
      ),
    );
  }

  static ThemeData darkMode(BuildContext context, {Color? kPrimaryColor, Color? kSecondaryColor, Color? kBackgroundColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: const Color(0xFF181818),
      shadowColor: const Color(0x8F000000),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor?.withOpacity(0.2),
      hoverColor: kPrimaryColor?.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFF1E1E1E),
      disabledColor: const Color(0xFFCCCCCC),
      textTheme: buildTextTheme(base: base.textTheme, fontColor: AppColors.font, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, fontColor: AppColors.font, myFontFamily: fontFamily),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.primary)),

      // Widgets Theme
      appBarTheme: AppBarTheme(
        color: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xff222222),
        surfaceTintColor: Colors.transparent,
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor ?? const Color(0xFF000000), width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: base.iconTheme.color,
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        error: errorColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        surface: AppColors.background,
      ),
    );
  }

/* ===================> Custom TextStyle <================== */
  static TextTheme buildTextTheme({required TextTheme base, String? myFontFamily, Color? fontColor}) {
    //? If not using responsive font remove both ".sp - 2.5"
    return base.copyWith(
      //* Display
      displayLarge: TextStyle(fontSize: (57.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: fontColor ?? base.displayLarge!.color, fontFamily: myFontFamily),
      displayMedium: TextStyle(fontSize: (45.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: fontColor ?? base.displayMedium!.color, fontFamily: myFontFamily),
      displaySmall: TextStyle(fontSize: (36.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: fontColor ?? base.displaySmall!.color, fontFamily: myFontFamily),

      //* Headline
      headlineLarge: TextStyle(fontSize: (32.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: fontColor ?? base.headlineLarge!.color, fontFamily: myFontFamily),
      headlineMedium: TextStyle(fontSize: (28.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: fontColor ?? base.headlineMedium!.color, fontFamily: myFontFamily),
      headlineSmall: TextStyle(fontSize: (24.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: fontColor ?? base.headlineSmall!.color, fontFamily: myFontFamily),

      //* Title
      titleLarge: TextStyle(fontSize: (22.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w500, color: fontColor ?? base.titleLarge!.color, fontFamily: myFontFamily),
      titleMedium: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: fontColor ?? base.titleMedium!.color, fontFamily: myFontFamily),
      titleSmall: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w500, color: fontColor ?? base.titleSmall!.color, fontFamily: myFontFamily),

      //* Label
      labelLarge: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w400, color: fontColor ?? base.labelLarge!.color, fontFamily: myFontFamily),
      labelMedium: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: fontColor ?? base.labelMedium!.color, fontFamily: myFontFamily),
      labelSmall: TextStyle(fontSize: (11.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: fontColor ?? base.labelSmall!.color, fontFamily: myFontFamily),

      //* Body Text
      bodyLarge: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: fontColor ?? base.bodyLarge!.color, fontFamily: myFontFamily),
      // This style is flutter default body textStyle (without textStyle)
      bodyMedium: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.25, fontWeight: FontWeight.w400, color: fontColor ?? base.bodyMedium!.color, fontFamily: myFontFamily),
      bodySmall: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.4, fontWeight: FontWeight.w400, color: fontColor ?? base.bodySmall!.color, fontFamily: myFontFamily),
    );
  }
}
