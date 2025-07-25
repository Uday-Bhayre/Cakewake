// import 'package:flutter/material.dart';

// var lightTheme = ThemeData(
//   colorScheme: ColorScheme(
//     brightness: Brightness.light,
//     primary: Color.fromARGB(255, 211, 133, 195),
//     onPrimary: Color(0xFFFFFFFF),
//     secondary: Color(0xFFFFFFFF),
//     onSecondary: Color(0xFF9CA3AF),
//     surface: Color(0xFFF2F2F7),
//     onSurface: Color(0xFF000000),
//     error: Color(0xFFB3261E),
//     onError: Color(0xFFFFFFFF),
//   ),
// );

// var darkTheme = ThemeData(
//   colorScheme: ColorScheme(
//     brightness: Brightness.dark,
//     primary: Color.fromARGB(255, 207, 126, 191),
//     onPrimary: Color(0xFFFFFFFF),
//     secondary: Color(0xFF454545),
//     onSecondary: Color(0xFF8A8A8A),
//     surface: Color(0xFF000000),
//     onSurface: Color(0xFFFFFFFF),
//     error: Color(0xFFB3261E),
//     onError: Color(0xFFFFFFFF),
//   ),
// );


import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(121, 116, 219, 1), // Lavender/Purple (matches splash and buttons)
      onPrimary: Color(0xFFFFFFFF), // White text/icons on purple
      secondary: Color(0xFFFFFFFF), // White (backgrounds, cards)
      onSecondary: Color(0xFF9E9E9E), 
      surface: Color(0xFFFFFFFF), // Light lavender (background)
      onSurface: Color(0xFF222222), // Dark text on light bg
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F4FB), // Matches background
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(121, 116, 219, 1), // Same purple for dark
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF232136), // Dark card/background
      onSecondary: Color(0xFF9E9E9E), 
      surface: Color(0xFF18162B), // Very dark background
      onSurface: Color(0xFFF6F4FB), // Light text on dark bg
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFF18162B),
  );
}