import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF84C93F);
  static const Color primaryAccent = Color(0xFF5CC7A0);
  static const Color primarySoft = Color(0xFFCAE7B4);

  static const Color bgTop = Color(0xFFF7F7FA);
  static const Color bgBottom = Color(0xFFF2F1EC);

  static const Color surface = Colors.white;
  static const Color navBg = Color(0xFFF5F6F2);

  static const Color textStrong = Color(0xFF101828);
  static const Color textDefault = Color(0xFF484848);
  static const Color textSubtle = Color(0xFF667394);

  static const Color border = Color(0xFFB8BCC6);
  static const Color borderSoft = Color(0xFFDCDFEB);

  static const Color shadow = Color(0x1A000000);

  static const Color brandGreen = primary;
  static const Color brandGreenSoft = primarySoft;

  static const Color background = bgTop;
  static const Color surfaceMuted = navBg;

  static const Color textPrimary = textStrong;
  static const Color textSecondary = textSubtle;
  static const Color textDisabled = textSubtle;

  static const Color tagProspectBg = Color(0xFFE7F1FF);
  static const Color tagProspectText = Color(0xFF1D4ED8);
  static const Color tagAttentionBg = Color(0xFFFFE4E6);
  static const Color tagAttentionText = Color(0xFFBE123C);
}
