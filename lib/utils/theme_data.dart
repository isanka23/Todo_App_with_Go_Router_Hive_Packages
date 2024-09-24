import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    colorScheme:
        const ColorScheme.dark().copyWith(primary: AppColors.kWhiteColor),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.kWhiteColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFabColor,
    ),
  );
}
