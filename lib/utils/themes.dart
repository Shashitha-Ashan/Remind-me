import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    labelLarge: GoogleFonts.poppins(),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
  iconTheme: const IconThemeData(color: Colors.white),
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    labelLarge: GoogleFonts.poppins(),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
  iconTheme: const IconThemeData(color: Colors.white),
);
