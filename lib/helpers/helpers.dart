import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message, ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(message, style: AppTextStyles.appButton),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
