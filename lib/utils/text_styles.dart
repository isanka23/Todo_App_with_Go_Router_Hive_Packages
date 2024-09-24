import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';

class AppTextStyles {
  static TextStyle appTitle = TextStyle(
    fontSize: 28,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appSubTitle = TextStyle(
    fontSize: 24,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle appDescriptionStyle = TextStyle(
    fontSize: 20,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle appDescriptionSmallStyle = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBody = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle appButton = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
