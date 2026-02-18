import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.textGrey,
      ),
    );
  }
}
