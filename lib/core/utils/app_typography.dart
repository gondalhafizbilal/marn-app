import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static TextTheme get textTheme {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      displayLarge: _style(72, _regular),
      displayMedium: _style(60, _regular),
      displaySmall: _style(48, _regular),
      headlineLarge: _style(44, _regular),
      headlineMedium: _style(36, _regular),
      headlineSmall: _style(28, _regular),
      titleLarge: _style(24, _regular),
      titleMedium: _style(20, _regular),
      titleSmall: _style(18, _regular),
      bodyLarge: _style(18, _regular),
      bodyMedium: _style(16, _regular),
      bodySmall: _style(14, _regular),
      labelLarge: _style(18, _regular),
      labelMedium: _style(16, _regular),
      labelSmall: _style(14, _regular),
    );
  }

  static TextStyle display1([Color? color]) =>
      _style(72, _regular, color: color);
  static TextStyle display2([Color? color]) =>
      _style(60, _regular, color: color);
  static TextStyle heading1([Color? color]) =>
      _style(44, _regular, color: color);
  static TextStyle heading2([Color? color]) =>
      _style(36, _regular, color: color);
  static TextStyle heading3([Color? color]) =>
      _style(28, _regular, color: color);
  static TextStyle heading4([Color? color]) =>
      _style(24, _regular, color: color);
  static TextStyle heading5([Color? color]) =>
      _style(20, _regular, color: color);
  static TextStyle paragraph1([Color? color]) =>
      _style(18, _regular, color: color);
  static TextStyle paragraph2([Color? color]) =>
      _style(16, _regular, color: color);
  static TextStyle paragraph3([Color? color]) =>
      _style(14, _regular, color: color);
  static TextStyle paragraph4([Color? color]) =>
      _style(12, _regular, color: color);
  static TextStyle label1([Color? color]) => _style(18, _regular, color: color);
  static TextStyle label2([Color? color]) => _style(16, _regular, color: color);
  static TextStyle label3([Color? color]) => _style(14, _regular, color: color);
  static TextStyle label4([Color? color]) => _style(12, _regular, color: color);
  static TextStyle label5([Color? color]) => _style(10, _regular, color: color);

  static TextStyle weight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }

  static TextStyle regular(TextStyle style) =>
      style.copyWith(fontWeight: _regular);
  static TextStyle medium(TextStyle style) =>
      style.copyWith(fontWeight: _medium);
  static TextStyle semiBold(TextStyle style) =>
      style.copyWith(fontWeight: _semiBold);
  static TextStyle bold(TextStyle style) => style.copyWith(fontWeight: _bold);

  static TextStyle _style(
    double fontSize,
    FontWeight fontWeight, {
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.25,
      letterSpacing: 0,
      color: color,
    );
  }
}
