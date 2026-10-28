import 'package:flutter/material.dart';
import 'package:marn/core/utils/app_colors.dart';

class AppShadows {
  static List<BoxShadow> xs = _shadow(0, 1, 2, .04);
  static List<BoxShadow> sm = _shadow(0, 2, 6, .06);
  static List<BoxShadow> md = _shadow(0, 6, 14, .08);
  static List<BoxShadow> lg = _shadow(0, 10, 24, .1);
  static List<BoxShadow> xl = _shadow(0, 16, 32, .12);
  static List<BoxShadow> x2l = _shadow(0, 22, 44, .14);
  static List<BoxShadow> x3l = _shadow(0, 30, 60, .16);

  static List<BoxShadow> _shadow(
    double dx,
    double dy,
    double blur,
    double alpha,
  ) {
    return [
      BoxShadow(
        color: AppColors.baseBlack.withValues(alpha: alpha),
        offset: Offset(dx, dy),
        blurRadius: blur,
      ),
    ];
  }
}
