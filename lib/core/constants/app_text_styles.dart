import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const bodySecondary = TextStyle(
    fontSize: 16,
    color: AppColors.textGrey,
  );

  static const caption = TextStyle(
    fontSize: 14,
    color: AppColors.textGrey,
  );

  static const small = TextStyle(
    fontSize: 12,
    color: AppColors.textGrey,
  );
}
