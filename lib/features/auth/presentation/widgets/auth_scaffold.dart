import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/routing/app_router.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.subtitleHighlight,
    this.showLanguageButton = true,
    this.headerGap,
    this.contentGap,
  });

  final String title;
  final String subtitle;
  final String? subtitleHighlight;
  final Widget child;
  final bool showLanguageButton;
  final double? headerGap;
  final double? contentGap;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.brandBeige,
        systemNavigationBarDividerColor: AppColors.brandBeige,
      ),
      child: Scaffold(
        backgroundColor: AppColors.brandBeige,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(25.w, 30.h, 25.w, 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 32.h,
                  child: Row(
                    children: [
                      _AuthBackButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRouter.login);
                          }
                        },
                      ),
                      const Spacer(),
                      if (showLanguageButton)
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.brandMaroon,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: AppTypography.heading4().copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          child: Text(strings.arabic),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: headerGap ?? 15.h),
                Text(
                  title,
                  style: AppTypography.heading3(
                    AppColors.gray900,
                  ).copyWith(fontWeight: FontWeight.w800, height: 1.08),
                ),
                SizedBox(height: 12.h),
                _AuthSubtitle(text: subtitle, highlight: subtitleHighlight),
                SizedBox(height: contentGap ?? 16.h),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthSubtitle extends StatelessWidget {
  const _AuthSubtitle({required this.text, this.highlight});

  final String text;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTypography.heading5(
      AppColors.gray400,
    ).copyWith(height: 1.34, fontWeight: FontWeight.w400);
    final highlight = this.highlight;

    if (highlight == null || highlight.isEmpty || !text.contains(highlight)) {
      return Text(text, style: baseStyle);
    }

    final parts = text.split(highlight);
    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: parts.first),
          TextSpan(
            text: highlight,
            style: baseStyle.copyWith(
              color: AppColors.brandMaroon,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (parts.length > 1)
            TextSpan(text: parts.sublist(1).join(highlight)),
        ],
      ),
    );
  }
}

class _AuthBackButton extends StatelessWidget {
  const _AuthBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tight(Size(32.r, 32.r)),
      style: IconButton.styleFrom(
        foregroundColor: AppColors.gray900,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(Icons.arrow_back, size: 26.r),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  });

  final String label;
  final String hint;
  final String? initialValue;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _LabeledAuthField(
      label: label,
      child: MarnFormField(
        label: '',
        hintText: hint,
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly,
        suffixIcon: suffixIcon,
        onTap: onTap,
      ),
    );
  }
}

class AuthPhoneField extends StatelessWidget {
  const AuthPhoneField({
    super.key,
    this.label,
    required this.countryCode,
    required this.initialValue,
    required this.onCountryChanged,
    this.onChanged,
  });

  final String? label;
  final String countryCode;
  final String initialValue;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final field = Row(
      children: [
        MarnCountryCodePicker(value: countryCode, onChanged: onCountryChanged),
        SizedBox(width: 12.w),
        Expanded(
          child: MarnFormField(
            label: '',
            initialValue: initialValue,
            keyboardType: TextInputType.phone,
            onChanged: onChanged,
          ),
        ),
      ],
    );

    if (label == null) return field;
    return _LabeledAuthField(label: label!, child: field);
  }
}

class AuthSelectField extends StatelessWidget {
  const AuthSelectField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _LabeledAuthField(
      label: label,
      child: MarnFormField(
        label: '',
        initialValue: value,
        readOnly: true,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.brandMaroon,
          size: 28.r,
        ),
      ),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MarnButton(
      label: label,
      onPressed: onPressed,
      size: MarnButtonSize.large,
      expand: true,
    );
  }
}

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton.apple({super.key}) : isApple = true;
  const AuthSocialButton.google({super.key}) : isApple = false;

  final bool isApple;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.r,
      height: 48.r,
      decoration: const BoxDecoration(
        color: AppColors.baseWhite,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: isApple
          ? Icon(Icons.apple, color: AppColors.baseBlack, size: 29.r)
          : Text(
              'G',
              style: AppTypography.heading3().copyWith(
                color: const Color(0xFF4285F4),
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }
}

class AuthOtpCodeField extends StatelessWidget {
  const AuthOtpCodeField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final chars = value.padRight(4).substring(0, 4).split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        final focused = index == value.length.clamp(0, 3);
        return SizedBox(
          width: 62.w,
          height: 62.h,
          child: TextField(
            autofocus: index == 2,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (digit) {
              final next = value.padRight(4).substring(0, 4).split('');
              next[index] = digit.isEmpty ? ' ' : digit[digit.length - 1];
              onChanged(next.join().replaceAll(' ', ''));
              if (digit.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: AppTypography.heading2(
              AppColors.baseBlack,
            ).copyWith(fontWeight: FontWeight.w800, height: 1),
            decoration: InputDecoration(
              counterText: '',
              hintText: chars[index].trim(),
              hintStyle: AppTypography.heading2(
                AppColors.baseBlack,
              ).copyWith(fontWeight: FontWeight.w800, height: 1),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: AppColors.baseWhite,
              enabledBorder: _otpBorder(focused),
              focusedBorder: _otpBorder(true),
            ),
          ),
        );
      }),
    );
  }

  OutlineInputBorder _otpBorder(bool focused) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.r),
      borderSide: BorderSide(
        color: focused ? AppColors.primary500 : AppColors.gray200,
        width: focused ? 1.2 : 1,
      ),
    );
  }
}

class _LabeledAuthField extends StatelessWidget {
  const _LabeledAuthField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.heading5(
            AppColors.gray900,
          ).copyWith(fontWeight: FontWeight.w800, height: 1.1),
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}
