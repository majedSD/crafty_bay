import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static final ThemeData appThemeData = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.grey,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
    ),
  );
}