import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    labelLarge: GoogleFonts.poppins(),
  ),
);
ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      labelLarge: GoogleFonts.poppins(),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.red));
