import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_with_provider/res/color.dart';

class AppStyle {
  static AppStyle instance = AppStyle._init();

  AppStyle._init();

  final TextStyle h2Bold = GoogleFonts.urbanist(
    color: AppColors.whiteColor,
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h4Bold = GoogleFonts.urbanist(
    color: AppColors.whiteColor,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h5Bold = GoogleFonts.urbanist(
    color: AppColors.whiteColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  final TextStyle bodyXlarge = GoogleFonts.urbanist(
    color: AppColors.whiteColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  final TextStyle bodyMedium = GoogleFonts.urbanist(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
