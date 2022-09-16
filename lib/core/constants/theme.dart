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
      onBackground: Color.fromARGB(255, 70, 70, 70),
      background: Colors.white,
      primary: Color.fromARGB(255, 23, 81, 165),
      onPrimary: Colors.white,
      secondary: Colors.amber.shade900,
      onSecondary: Colors.white,
      onTertiary: Color.fromARGB(255, 170, 170, 170),
      primaryContainer: Color.fromARGB(255, 247, 247, 247),
      onPrimaryContainer: Color.fromARGB(255, 172, 172, 172),
      secondaryContainer: Color.fromARGB(255, 245, 245, 245),
      onSecondaryContainer: Color.fromARGB(255, 195, 195, 195),
    ));
final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Color(0xFF151515),
    fontFamily: 'Poppins',
    dividerColor: Color.fromARGB(12, 23, 82, 165),
    colorScheme: ColorScheme.dark(
      background: Color.fromARGB(255, 21, 21, 21),
      onBackground: Color.fromARGB(255, 214, 214, 214),
      primary: Color.fromARGB(255, 25, 102, 209),
      onPrimary: Colors.white,
      secondary: Colors.amber.shade900,
      onSecondary: Colors.white,
      onTertiary: Color.fromARGB(255, 136, 136, 136),
      primaryContainer: Color.fromARGB(255, 25, 25, 25),
      onPrimaryContainer: Color.fromARGB(255, 136, 136, 136),
      secondaryContainer: Color.fromARGB(255, 160, 160, 160),
      onSecondaryContainer: Color.fromARGB(255, 170, 170, 170),
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color.fromARGB(0, 255, 255, 255),
        foregroundColor: Colors.black87,
        centerTitle: true));
