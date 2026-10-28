import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/core/utils/layout_tokens.dart';

class MarnStateView extends StatelessWidget {
  const MarnStateView({
    super.key,
    required this.isLoading,
    required this.child,
    this.emptyMessage,
    this.emptyIllustrationAsset,
  });

  final bool isLoading;
  final Widget child;
  final String? emptyMessage;
  final String? emptyIllustrationAsset;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (emptyMessage != null) {
      return MarnEmptyState(
        message: emptyMessage!,
        illustrationAsset: emptyIllustrationAsset,
      );
    }

    return child;
  }
}

class MarnEmptyState extends StatelessWidget {
  const MarnEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.illustrationAsset,
  });

  final String message;
  final IconData icon;
  final String? illustrationAsset;

  @override
  Widget build(BuildContext context) {
    return MarnCardSurface(
      child: Column(
        children: [
          if (illustrationAsset == null)
            Icon(icon, size: 40, color: AppColors.primary600)
          else
            MarnIllustration(
              illustrationAsset!,
              height: 138.h,
              semanticLabel: message,
            ),
          SizedBox(height: illustrationAsset == null ? 12.h : 14.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.paragraph2(AppColors.gray600),
          ),
        ],
      ),
    );
  }
}

class MarnIllustration extends StatelessWidget {
  const MarnIllustration(
    this.asset, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  final String asset;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      width: width,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }
}

class MarnIllustratedPanel extends StatelessWidget {
  const MarnIllustratedPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustrationAsset,
    this.action,
  });

  final String title;
  final String subtitle;
  final String illustrationAsset;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return MarnCardSurface(
      borderColor: Colors.transparent,
      child: Column(
        children: [
          MarnIllustration(
            illustrationAsset,
            height: 178.h,
            semanticLabel: title,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.heading5(
              AppColors.baseDark,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.paragraph3(
              AppColors.gray600,
            ).copyWith(height: 1.45),
          ),
          if (action != null) ...[SizedBox(height: 16.h), action!],
        ],
      ),
    );
  }
}

class MarnHeroPanel extends StatelessWidget {
  const MarnHeroPanel({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
    this.icon = Icons.auto_awesome_rounded,
    this.iconAsset,
  });

  final String title;
  final String subtitle;
  final Widget? action;
  final IconData icon;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return MarnCardSurface(
      borderColor: Colors.transparent,
      gradient: const LinearGradient(
        colors: [AppColors.primary600, AppColors.primary800],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.heading4(
                    AppColors.baseWhite,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: AppTypography.paragraph3(
                    AppColors.baseWhite.withValues(alpha: .86),
                  ).copyWith(height: 1.45),
                ),
                if (action != null) ...[SizedBox(height: 16.h), action!],
              ],
            ),
          ),
          SizedBox(width: 16.w),
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.baseWhite.withValues(alpha: .16),
            child: iconAsset == null
                ? Icon(icon, color: AppColors.baseWhite, size: 30)
                : MarnAssetIcon(
                    iconAsset!,
                    color: AppColors.baseWhite,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }
}

class MarnActionRow extends StatelessWidget {
  const MarnActionRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconAsset,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? iconAsset;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.baseWhite,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray200),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.primary50,
                child: iconAsset == null
                    ? Icon(icon, color: AppColors.primary600)
                    : MarnAssetIcon(
                        iconAsset!,
                        size: 22,
                        color: AppColors.primary600,
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.paragraph2(
                        AppColors.baseDark,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppTypography.paragraph4(AppColors.gray500),
                    ),
                  ],
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary600,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarnMetricTile extends StatelessWidget {
  const MarnMetricTile({
    super.key,
    required this.value,
    required this.label,
    this.icon,
  });

  final String value;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MarnCardSurface(
        padding: EdgeInsets.all(14.w),
        borderRadius: 18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) Icon(icon, color: AppColors.primary600, size: 20),
            if (icon != null) SizedBox(height: 8.h),
            Text(
              value,
              style: AppTypography.heading5(
                AppColors.baseDark,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 4.h),
            Text(label, style: AppTypography.paragraph4(AppColors.gray500)),
          ],
        ),
      ),
    );
  }
}

class MarnSearchField extends StatelessWidget {
  const MarnSearchField({
    super.key,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onFilterTap,
    this.controller,
  });

  final String hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Center(
          widthFactor: 1,
          heightFactor: 1,
          child: MarnAssetIcon(MarnIconAssets.search, size: 24),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 40.h),
        suffixIcon: onClear == null && onFilterTap == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onClear != null)
                    IconButton(
                      tooltip: 'Clear search',
                      onPressed: onClear,
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.primary800,
                    ),
                  if (onFilterTap != null)
                    IconButton(
                      tooltip: 'Filters',
                      onPressed: onFilterTap,
                      icon: const MarnAssetIcon(
                        MarnIconAssets.filter,
                        size: 22,
                        color: AppColors.primary800,
                      ),
                    ),
                ],
              ),
        hintStyle: AppTypography.paragraph3(
          AppColors.grayModern400,
        ).copyWith(height: 18 / 14),
        filled: true,
        fillColor: AppColors.baseWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary600),
        ),
      ),
    );
  }
}

class MarnFormField extends StatelessWidget {
  const MarnFormField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  });

  final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      style: AppTypography.paragraph1(
        const Color(0xFF1F2A37),
      ).copyWith(fontWeight: FontWeight.w400, height: 1.25),
      decoration: InputDecoration(
        labelText: label.isEmpty ? null : label,
        hintText: hintText,
        hintStyle: AppTypography.paragraph1(
          const Color(0xFF9DA4AE),
        ).copyWith(fontWeight: FontWeight.w400, height: 1.25),
        filled: true,
        fillColor: AppColors.baseWhite,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        suffixIcon: suffixIcon,
        border: _marnInputBorder(_marnInputBorderColor),
        enabledBorder: _marnInputBorder(_marnInputBorderColor),
        focusedBorder: _marnInputBorder(AppColors.primary600),
      ),
    );

    if (maxLines == 1) {
      return SizedBox(width: double.infinity, height: 52.h, child: field);
    }

    return field;
  }

  static const _marnInputBorderColor = Color(0xFFD2D6DB);

  static OutlineInputBorder _marnInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color),
    );
  }
}

class MarnCountryCode {
  const MarnCountryCode({
    required this.country,
    required this.dialCode,
    required this.flag,
  });

  final String country;
  final String dialCode;
  final String flag;

  String get label => '$flag $dialCode';
}

class MarnCountryCodePicker extends StatelessWidget {
  const MarnCountryCodePicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.items = defaultItems,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final List<MarnCountryCode> items;

  static const defaultItems = [
    MarnCountryCode(country: 'Qatar', dialCode: '+974', flag: 'QA'),
    MarnCountryCode(country: 'Saudi Arabia', dialCode: '+966', flag: 'SA'),
    MarnCountryCode(
      country: 'United Arab Emirates',
      dialCode: '+971',
      flag: 'AE',
    ),
    MarnCountryCode(country: 'Kuwait', dialCode: '+965', flag: 'KW'),
    MarnCountryCode(country: 'Bahrain', dialCode: '+973', flag: 'BH'),
    MarnCountryCode(country: 'Oman', dialCode: '+968', flag: 'OM'),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = items.firstWhere(
      (item) => item.dialCode == value,
      orElse: () => items.first,
    );

    return SizedBox(
      width: 112.w,
      height: 52.h,
      child: DropdownButtonFormField<String>(
        initialValue: selected.dialCode,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.brandMaroon,
          size: 28.r,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.baseWhite,
          contentPadding: EdgeInsetsDirectional.only(start: 16.w),
          border: _pickerBorder(_pickerBorderColor),
          enabledBorder: _pickerBorder(_pickerBorderColor),
          focusedBorder: _pickerBorder(AppColors.primary600),
        ),
        selectedItemBuilder: (context) {
          return items
              .map(
                (item) => Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    item.dialCode,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.paragraph1(
                      const Color(0xFF1F2A37),
                    ).copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              )
              .toList();
        },
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item.dialCode,
                child: Text('${item.dialCode}  ${item.country}'),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  static const _pickerBorderColor = Color(0xFFD2D6DB);

  static OutlineInputBorder _pickerBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color),
    );
  }
}

enum MarnButtonVariant { primary, secondary, tertiary }

enum MarnButtonSize { small, medium, large }

class MarnButton extends StatelessWidget {
  const MarnButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MarnButtonVariant.primary,
    this.size = MarnButtonSize.medium,
    this.leading,
    this.trailing,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final MarnButtonVariant variant;
  final MarnButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final colors = _MarnButtonColors.forVariant(variant, enabled: enabled);
    final height = switch (size) {
      MarnButtonSize.small => LayoutTokens.buttonHeightSmall,
      MarnButtonSize.medium => LayoutTokens.buttonHeightMedium,
      MarnButtonSize.large => LayoutTokens.buttonHeightLarge,
    };
    final horizontalPadding = switch (size) {
      MarnButtonSize.small => 12.w,
      MarnButtonSize.medium => 16.w,
      MarnButtonSize.large => 20.w,
    };
    final textStyle = switch (size) {
      MarnButtonSize.small => AppTypography.label4(colors.foreground),
      MarnButtonSize.medium => AppTypography.label3(colors.foreground),
      MarnButtonSize.large => AppTypography.paragraph2(colors.foreground),
    }.copyWith(fontWeight: FontWeight.w700);

    final labelText = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: textStyle,
    );

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          IconTheme(
            data: IconThemeData(color: colors.foreground, size: 18),
            child: leading!,
          ),
          SizedBox(width: 8.w),
        ],
        if (expand) Flexible(child: labelText) else labelText,
        if (trailing != null) ...[
          SizedBox(width: 8.w),
          IconTheme(
            data: IconThemeData(color: colors.foreground, size: 18),
            child: trailing!,
          ),
        ],
      ],
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: height.h,
      child: Material(
        color: colors.background,
        borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
              border: Border.all(color: colors.border),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _MarnButtonColors {
  const _MarnButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;

  static _MarnButtonColors forVariant(
    MarnButtonVariant variant, {
    required bool enabled,
  }) {
    if (!enabled) {
      return const _MarnButtonColors(
        background: AppColors.primary50,
        foreground: AppColors.primary300,
        border: AppColors.primary50,
      );
    }

    return switch (variant) {
      MarnButtonVariant.primary => const _MarnButtonColors(
        background: AppColors.primary600,
        foreground: AppColors.baseWhite,
        border: AppColors.primary600,
      ),
      MarnButtonVariant.secondary => const _MarnButtonColors(
        background: AppColors.baseWhite,
        foreground: AppColors.primary600,
        border: AppColors.primary600,
      ),
      MarnButtonVariant.tertiary => const _MarnButtonColors(
        background: Colors.transparent,
        foreground: AppColors.primary600,
        border: Colors.transparent,
      ),
    };
  }
}

class MarnChoicePill extends StatelessWidget {
  const MarnChoicePill({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.leading,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColors.baseWhite : AppColors.primary600;

    return Material(
      color: selected ? AppColors.primary600 : Colors.transparent,
      borderRadius: BorderRadius.circular(LayoutTokens.pillRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(LayoutTokens.pillRadius),
        child: Container(
          constraints: BoxConstraints(minHeight: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LayoutTokens.pillRadius),
            border: Border.all(color: AppColors.primary600),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                IconTheme(
                  data: IconThemeData(size: 14, color: foreground),
                  child: leading!,
                ),
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: AppTypography.label4(
                  foreground,
                ).copyWith(fontWeight: FontWeight.w600, height: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarnCheckboxTile extends StatelessWidget {
  const MarnCheckboxTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final active = enabled && value;
    final borderColor = value ? AppColors.primary800 : AppColors.grayModern300;
    final labelColor = enabled ? AppColors.baseDark : AppColors.gray400;

    return InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.paragraph2(
                  labelColor,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: active ? AppColors.primary800 : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: active
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.baseWhite,
                      size: 20,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class MarnSegmentedTabs extends StatelessWidget {
  const MarnSegmentedTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.grayModern200,
        borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onChanged(i),
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selectedIndex
                        ? AppColors.primary600
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tabs[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.paragraph3(
                      i == selectedIndex
                          ? AppColors.baseWhite
                          : AppColors.grayModern400,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum MarnFieldState { normal, error, success }

class MarnTextInput extends StatelessWidget {
  const MarnTextInput({
    super.key,
    required this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.state = MarnFieldState.normal,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
  });

  final String label;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final MarnFieldState state;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final borderColor = switch (state) {
      MarnFieldState.error => AppColors.error400,
      MarnFieldState.success => AppColors.success400,
      MarnFieldState.normal => AppColors.gray200,
    };
    final helperColor = switch (state) {
      MarnFieldState.error => AppColors.error400,
      MarnFieldState.success => AppColors.success500,
      MarnFieldState.normal => AppColors.grayModern400,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label4(
            AppColors.baseDark,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled ? AppColors.baseWhite : AppColors.grayTrue100,
            hintStyle: AppTypography.paragraph3(AppColors.grayModern400),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: maxLines > 1 ? 14.h : 0,
            ),
            constraints: maxLines == 1
                ? BoxConstraints(minHeight: LayoutTokens.inputHeightMedium.h)
                : null,
            border: _inputBorder(borderColor),
            enabledBorder: _inputBorder(borderColor),
            disabledBorder: _inputBorder(AppColors.gray200),
            focusedBorder: _inputBorder(AppColors.primary600),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: 6.h),
          Text(helperText!, style: AppTypography.label5(helperColor)),
        ],
      ],
    );
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(LayoutTokens.radiusSm),
      borderSide: BorderSide(color: color),
    );
  }
}

class MarnStatusPill extends StatelessWidget {
  const MarnStatusPill({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
  });

  const MarnStatusPill.completed({super.key, this.label = 'Completed'})
    : foreground = AppColors.success700,
      background = AppColors.success100;

  const MarnStatusPill.pending({super.key, this.label = 'Pending'})
    : foreground = AppColors.error400,
      background = AppColors.error100;

  final String label;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(LayoutTokens.pillRadius),
      ),
      child: Text(
        label,
        style: AppTypography.paragraph2(
          foreground,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
