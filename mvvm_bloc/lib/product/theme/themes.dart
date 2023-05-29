import 'package:flutter/material.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';

class ProjectThemes {
  static final lightThemeContext = ThemeData.light();

  static final lightTheme = lightThemeContext.copyWith(
    textTheme: ThemeData.light().textTheme.copyWith(
          displaySmall: lightThemeContext.textTheme.displaySmall!.copyWith(
            color: ColorName.displayColor,
          ),
        ),
  );
}
