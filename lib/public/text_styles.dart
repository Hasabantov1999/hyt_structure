import 'color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get regular => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorPalette.mainColors.darkBlue,
        fontFamily: GoogleFonts.rubik().fontFamily,
      );
  static TextStyle get medium => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorPalette.mainColors.darkBlue,
        fontFamily: GoogleFonts.rubik().fontFamily,
      );
  static TextStyle get numberStyles => TextStyle(
        color: const Color(0xFF15203D),
        fontSize: 16,
        fontFamily: GoogleFonts.rubik().fontFamily,
        fontWeight: FontWeight.w500,
      );
}
