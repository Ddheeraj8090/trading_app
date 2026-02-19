import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF9F6FF);

  static const primary = Color(0xFF7C5CD6);
  static const darkPurple = Color(0xFF5E3DB3);

  static const cardGrey = Color(0xFFF4F4F6);
  static const white = Color(0xFFFFFFFF);

  static const success = Color(0xFF00C853);
  static const error = Color(0xFFFF3B30);
  static const blue = Color(0xFF2962FF);

  static const textColor = Color(0xFF222222);
  static const textGrey = Color(0xFF747474);
  static const chartTextColor = Color(0xFFAC876C);
  static const textLight = Color(0xFFA0A0A0);

  static const border = Color(0xFFE0E0E0);
  static const black = Color(0xFF000000);
  static const black87 = Color(0xFF1A1A1A);
  static const white70 = Color(0xB3FFFFFF);
  static const priceCardBackground = Color(0xFFF8F8F8);

  static const shadowPurple = Color(0xFFC28FEA);
  static const badgeBorder = Color(0xFFDFC5EC);
  static const badgeShadow = Color(0xFF6D0404);
  static const badgeRedStart = Color(0xFFA71212);
  static const badgeRedEnd = Color(0xFFFF0000);

  static const topGradientStart = Color(0x66436EDD);
  static const topGradientMiddle = Color(0x66AF7CE3);
  static const topGradientEnd = Color(0x66AF69C7);

  static const accentGradientStart = Color(0xFF436EDD);
  static const accentGradientMiddle = Color(0xFFAF7CE3);
  static const accentGradientEnd = Color(0xFFAF69C7);

  static const Color footerStart = Color(0xFF6768E1);
  static const Color footerEnd = Color(0xFF4A419C);
  static const systemNavigationBar = footerStart;

  static const axisBadgeStart = Color(0xFFB11762);
  static const axisBadgeEnd = Color(0xFFD04E8C);
  static const hdfcBadgeStart = Color(0xFF004A9F);
  static const hdfcBadgeEnd = Color(0xFF0A72D8);
  static const sbinBadgeStart = Color(0xFF1F6DF0);
  static const sbinBadgeEnd = Color(0xFF4E90FF);
  static const iciciBadgeStart = Color(0xFF7E2F18);
  static const iciciBadgeEnd = Color(0xFFC1552D);
  static const relianceBadgeStart = Color(0xFF3A2C9E);
  static const relianceBadgeEnd = Color(0xFF6457D3);
  static const infyBadgeStart = Color(0xFF0F8A78);
  static const infyBadgeEnd = Color(0xFF28B4A0);
  static const fallbackBadgeStart = Color(0xFF5E5E5E);
  static const fallbackBadgeEnd = Color(0xFF8C8C8C);

  static const LinearGradient footerGradient = LinearGradient(
    colors: [footerStart, footerEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient topOverlayGradient = LinearGradient(
    colors: [topGradientStart, topGradientMiddle, topGradientEnd],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentGradientStart, accentGradientMiddle, accentGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentBarGradient = LinearGradient(
    colors: [accentGradientStart, accentGradientMiddle, accentGradientEnd],
  );

  static const LinearGradient badgeNotificationGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [badgeRedStart, badgeRedEnd],
  );

  static const LinearGradient walletAmountGradient = LinearGradient(
    colors: [footerStart, footerEnd],
  );
}
