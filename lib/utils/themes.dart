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
    labelSmall: GoogleFonts.poppins(
      color: const Color(0xFFDFDEDE),
    ),
  ),
  primaryColor: const Color(0xFF0F111D),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF181B2E),
    titleTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  switchTheme: const SwitchThemeData(
    thumbColor: WidgetStatePropertyAll<Color>(Color(0xFFFFFFFF)),
    trackColor: WidgetStatePropertyAll<Color>(Color(0xFF454545)),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Color(0xFF1C1F30),
  ),
  dividerColor: Colors.white,
  cardColor: Color(0xFF424242),
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
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.poppins(
      color: const Color(0xFF646464),
    ),
  ),
  primaryColor: Colors.white,
  brightness: Brightness.light,
  buttonTheme: const ButtonThemeData(),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFE85566),
    titleTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  switchTheme: const SwitchThemeData(
    thumbColor: WidgetStatePropertyAll<Color>(Color(0xFF6D77FB)),
    trackColor: WidgetStatePropertyAll<Color>(Color(0xFFFFFFFF)),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Color(0x90E4EDF7),
  ),
  dividerColor: Colors.black38,
);
