import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
final TextStyle placeholderTextFieldStyle =
    TextStyle(color: Colors.grey.shade400);

final appTheme= ThemeData(
   appBarTheme: AppBarTheme(
      color: Colors.grey.shade900,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 26.0, fontFamily: GoogleFonts.rubik().fontFamily)),
  brightness: Brightness.light,
  primaryColor: Colors.grey.shade900,
  fontFamily: GoogleFonts.outfit().fontFamily,
  // fontFamily: 'Open sans',
  textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: 36.0),
      displayMedium: const TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: const TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      bodySmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade400)),
);
