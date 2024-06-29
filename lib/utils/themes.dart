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
  appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
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
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
  iconTheme: const IconThemeData(color: Colors.white),
);
