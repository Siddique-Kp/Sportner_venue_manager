import 'package:flutter/material.dart';

// colors
class AppColors {
  static const scaffoldColor = Colors.white;
  static const kButtonColor = Color(0xFF00B562);
  static const appColor = Color.fromARGB(255, 0, 181, 98);
  static const white = Colors.white;
  static const black = Colors.black;
  static const lightBlackColor = Colors.black54;
  static const grey = Colors.grey;
  static const lightgrey = Color.fromARGB(45, 158, 158, 158);
}

class PrimaryColor {
  static MaterialColor appColor = const MaterialColor(
    0xFF00B562,
    <int, Color>{
      50: Color(0xFFE6F7EA),
      100: Color(0xFFB3E6C9),
      200: Color(0xFF80D6A8),
      300: Color(0xFF4DC687),
      400: Color(0xFF26B974),
      500: Color(0xFF00B562),
      600: Color(0xFF00B05A),
      700: Color(0xFF00A751),
      800: Color(0xFF009F49),
      900: Color(0xFF008F3B),
    },
  );
}
