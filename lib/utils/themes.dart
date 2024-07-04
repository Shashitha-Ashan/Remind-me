import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.poppins(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFE85566),
    titleTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black,
    ),
    displayLarge: GoogleFonts.poppins(
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.poppins(
      color: Colors.white,
    ),
  ),
  buttonTheme: ButtonThemeData(),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFE85566),
    titleTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
);
