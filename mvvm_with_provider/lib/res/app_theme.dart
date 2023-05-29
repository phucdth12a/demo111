import 'package:flutter/material.dart';
import 'package:mvvm_with_provider/res/color.dart';
import 'package:mvvm_with_provider/res/style/app_style.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
      primaryColor: AppColors.redColor,
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColors.whiteColor,
        scrolledUnderElevation: 2,
        toolbarTextStyle: AppStyle.instance.bodyMedium,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fillColor: MaterialStateProperty.all(AppColors.redColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.whiteColor.withOpacity(0.1),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.redColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: AppColors.redColor,
        contentPadding: const EdgeInsets.all(20),
        prefixIconColor: AppColors.whiteColor.withOpacity(0.4),
        suffixIconColor: AppColors.whiteColor.withOpacity(0.4),
        hintStyle: AppStyle.instance.bodyMedium.copyWith(
          color: AppColors.whiteColor.withOpacity(0.4),
        ),
      ),
    );
  }
}
