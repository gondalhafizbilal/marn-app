import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_shadows.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/core/utils/layout_tokens.dart';

class MarnPageScaffold extends StatelessWidget {
  const MarnPageScaffold({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.showBackButton = false,
    this.onBackPressed,
    this.showTopPadding = true,
    this.background,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showTopPadding;
  final Decoration? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          background ?? const BoxDecoration(color: AppColors.brandBeige),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (title != null || subtitle != null || trailing != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    LayoutTokens.pagePadding.w,
                    showTopPadding ? 12.h : 0,
                    LayoutTokens.pagePadding.w,
                    0,
                  ),
                  child: _PageHeader(
                    title: title,
                    subtitle: subtitle,
                    trailing: trailing,
                    showBackButton: showBackButton,
                    onBackPressed: onBackPressed,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  LayoutTokens.pagePadding.w,
                  16.h,
                  LayoutTokens.pagePadding.w,
                  0,
                ),
                child: child,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 32.h)),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    this.title,
    this.subtitle,
    this.trailing,
    required this.showBackButton,
    this.onBackPressed,
  });

  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBackButton) ...[
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: MarnBackButton(onPressed: onBackPressed),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: AppTypography.heading4(
                    AppColors.baseDark,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              if (subtitle != null) ...[
                SizedBox(height: 8.h),
                Text(
                  subtitle!,
                  style: AppTypography.paragraph2(
                    AppColors.gray500,
                  ).copyWith(height: 1.45),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: 12.w), trailing!],
      ],
    );
  }
}

class MarnBackButton extends StatelessWidget {
  const MarnBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(12),
          child: const MarnAssetIcon(MarnIconAssets.arrowLeft, size: 24),
        ),
      ),
    );
  }
}

class MarnSectionTitle extends StatelessWidget {
  const MarnSectionTitle({
    super.key,
    required this.title,
    this.action,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.heading5(
                  AppColors.baseDark,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle!,
                  style: AppTypography.paragraph3(AppColors.gray500),
                ),
              ],
            ],
          ),
        ),
        action ?? const SizedBox.shrink(),
      ],
    );
  }
}

class MarnPill extends StatelessWidget {
  const MarnPill({
    super.key,
    required this.label,
    this.color = AppColors.primary600,
    this.backgroundColor,
    this.icon,
  });

  final String label;
  final Color color;
  final Color? backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            SizedBox(width: 6.w),
          ],
          Text(
            label,
            style: AppTypography.paragraph3(
              color,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class MarnCardSurface extends StatelessWidget {
  const MarnCardSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.gradient,
    this.borderRadius = 24,
    this.elevation = 0,
    this.shadows,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Gradient? gradient;
  final double borderRadius;
  final double elevation;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shadowColor: AppColors.baseBlack.withValues(alpha: .08),
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          color: gradient == null ? AppColors.baseWhite : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? AppColors.gray200),
          boxShadow: shadows ?? (elevation > 0 ? AppShadows.sm : null),
        ),
        child: Padding(padding: padding ?? EdgeInsets.all(18.w), child: child),
      ),
    );
  }
}
