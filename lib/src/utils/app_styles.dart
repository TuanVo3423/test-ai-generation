import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles._();

  static TextStyle title26Bold() {
    return const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 38 / 26,
      letterSpacing: 0,
    );
  }

  static TextStyle body14Bold(Color color) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 17 / 14,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle body14Medium(Color color) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 22 / 14,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle label12(Color color) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 20 / 12,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle radio16(Color color) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 19 / 16,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle button18Bold() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 20 / 18,
      letterSpacing: 0,
      color: AppColors.white,
    );
  }
}
