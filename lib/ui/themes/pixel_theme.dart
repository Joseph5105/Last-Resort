import 'package:flutter/material.dart';
import '../../public/colors.dart';

class PixelTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: OldWinColors.background,
      primaryColor: OldWinColors.blue,
      fontFamily: 'PixelFont',
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
    );
  }
}
