import 'package:flutter/material.dart';

final ThemeData light = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 248, 248, 248),
    fontFamily: 'Poppins',
    dividerColor: Color.fromARGB(255, 245, 245, 245),
    appBarTheme: AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.black87,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        centerTitle: true),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 248, 248, 248),
      onBackground: Color.fromARGB(255, 60, 60, 60),
      primary: Color.fromARGB(255, 23, 81, 165),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 94, 0, 218),
      onSecondary: Colors.white,
      onTertiary: Color.fromARGB(255, 170, 170, 170),
      primaryContainer: Colors.white,
      onPrimaryContainer: Color.fromARGB(255, 92, 92, 92),
      secondaryContainer: Color.fromARGB(255, 215, 215, 215),
      onSecondaryContainer: Color.fromARGB(255, 155, 155, 155),
    ));
final ThemeData dark = ThemeData(
  scaffoldBackgroundColor: Color(0xFF151515),
  fontFamily: 'Poppins',
  dividerColor: Color.fromARGB(20, 23, 86, 175),
  appBarTheme: AppBarTheme(
      elevation: 0,
      color: Color.fromARGB(0, 255, 255, 255),
      foregroundColor: Colors.black87,
      centerTitle: true),
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Color.fromARGB(255, 22, 22, 22)),
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 24, 24, 24),
    onBackground: Color.fromARGB(255, 218, 218, 218),
    primary: Color.fromARGB(255, 23, 86, 175),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 94, 0, 218),
    onSecondary: Colors.white,
    onTertiary: Color.fromARGB(255, 136, 136, 136),
    primaryContainer: Color.fromARGB(255, 35, 35, 35),
    onPrimaryContainer: Color.fromARGB(255, 189, 189, 189),
    secondaryContainer: Color.fromARGB(255, 160, 160, 160),
    onSecondaryContainer: Color.fromARGB(255, 170, 170, 170),
  ),
);
