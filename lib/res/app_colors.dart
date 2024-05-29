import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// App Specific Colors
  static Color primary = const Color(0xFF221361);
  static Color lightPrimary = const Color(0xFF686185);
  static Color secondary = const Color(0xFFD89B00);
  static Color lightSecondary = const Color.fromARGB(255, 255, 237, 205);
  static const Color background = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFFF0000);

  static const Color font = Color(0xFF1E2A3B);
  static const Color green = Color(0xFF08AC53);
  static const Color hold = Color(0xFFF8961E);

  /// Common Colors
  static const Color lightGrey = Color(0xFFD4D4D4);
  static const Color textFiledBorder = Color(0xFFE2E8F0);
  static const Color outlineButtonBorder = Color(0xFFE2E8F0);

  static List<Color> bannerGradientColorList = [
    const Color(0xff169A8A).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFF417E).withOpacity(0.1),
  ];

  // Get dark or light brightness according to the [backgroundColor] color.
  static Color getColorOnBackground(Color backgroundColor, {bool reverse = false}) {
    if (backgroundColor.computeLuminance() < 0.5) {
      return reverse == true ? Colors.black : Colors.white;
    } else {
      return reverse == true ? Colors.white : Colors.black;
    }
  }

  /// Hex to convert Color
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Color to convert Hex
  static String fromColor(Color color) {
    String hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    return hex;
  }
}
