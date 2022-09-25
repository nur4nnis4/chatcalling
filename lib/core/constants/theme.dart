import 'package:flutter/material.dart';

final ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    dividerColor: Color.fromRGBO(248, 248, 248, 1),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.white70,
        foregroundColor: Colors.black87,
        centerTitle: true),
    colorScheme: ColorScheme.light(
      background: Colors.white,
      onBackground: Color.fromARGB(255, 60, 60, 60),
      primary: Color.fromARGB(255, 23, 81, 165),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 94, 0, 218),
      onSecondary: Colors.white,
      onTertiary: Color.fromARGB(255, 170, 170, 170),
      primaryContainer: Color.fromARGB(255, 244, 244, 244),
      onPrimaryContainer: Color.fromARGB(255, 92, 92, 92),
      secondaryContainer: Color.fromARGB(255, 215, 215, 215),
      onSecondaryContainer: Color.fromARGB(255, 155, 155, 155),
      tertiaryContainer: Color.fromARGB(255, 45, 103, 185),
      onTertiaryContainer: Color.fromARGB(157, 223, 236, 255),
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
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 21, 21, 21),
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
