import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';

class ProfileDesignTokens {
  static const background = AppColors.brandBeige;
  static const surface = AppColors.baseWhite;
  static const text = Color(0xFF1F2A37);
  static const muted = Color(0xFFA7B0BD);
  static const border = Color(0xFFD3D8DF);
  static const chevron = Color(0xFFD0D5DD);
  static const danger = Color(0xFFE92D26);
}

class MarnProfileHeaderBar extends StatelessWidget {
  const MarnProfileHeaderBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.trailing,
  });

  final String title;
  final bool showBackButton;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBackButton)
            const Align(
              alignment: Alignment.centerLeft,
              child: MarnBackButton(),
            ),
          Text(
            title,
            style: AppTypography.heading4(ProfileDesignTokens.text).copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          if (trailing != null)
            Align(alignment: Alignment.centerRight, child: trailing!),
        ],
      ),
    );
  }
}

class MarnProfileAvatar extends StatelessWidget {
  const MarnProfileAvatar({
    super.key,
    this.asset,
    this.size = 132,
    this.badgeSize = 42,
    this.onCameraTap,
  });

  final String? asset;
  final double size;
  final double badgeSize;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipOval(
              child: asset == null
                  ? Container(
                      color: AppColors.primary50,
                      child: Icon(
                        Icons.person_rounded,
                        size: size.w * .62,
                        color: AppColors.primary600,
                      ),
                    )
                  : Image.asset(asset!, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            right: 5.w,
            bottom: 0,
            child: GestureDetector(
              onTap: onCameraTap,
              child: Container(
                width: badgeSize.w,
                height: badgeSize.w,
                decoration: const BoxDecoration(
                  color: AppColors.brandMaroon,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.baseWhite,
                  size: (badgeSize * .48).w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarnProfileMenuItem extends StatelessWidget {
  const MarnProfileMenuItem({
    super.key,
    required this.label,
    this.icon,
    this.iconAsset,
    this.onTap,
    this.destructive = false,
    this.showChevron = true,
  });

  final String label;
  final IconData? icon;
  final String? iconAsset;
  final VoidCallback? onTap;
  final bool destructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final color = destructive
        ? ProfileDesignTokens.danger
        : AppColors.brandMaroon;
    final textColor = destructive
        ? ProfileDesignTokens.danger
        : ProfileDesignTokens.text;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 64.h,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 327.w,
            height: 24.h,
            child: Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: iconAsset == null
                      ? Icon(icon, size: 24.w, color: color)
                      : MarnAssetIcon(iconAsset!, size: 24.w, color: color),
                ),
                SizedBox(width: 40.w),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label4(textColor).copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 18 / 12,
                    ),
                  ),
                ),
                if (showChevron)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: ProfileDesignTokens.chevron,
                    size: 24.w,
                  ),
                if (!showChevron) SizedBox(width: 24.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MarnEditProfileInput extends StatelessWidget {
  const MarnEditProfileInput({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.heading5(
            ProfileDesignTokens.text,
          ).copyWith(fontSize: 21.sp, fontWeight: FontWeight.w800, height: 1.2),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTypography.heading4(
            ProfileDesignTokens.text,
          ).copyWith(fontSize: 23.sp, fontWeight: FontWeight.w400, height: 1.1),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.baseWhite,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            constraints: BoxConstraints(minHeight: 66.h),
            border: _border(ProfileDesignTokens.border),
            enabledBorder: _border(ProfileDesignTokens.border),
            focusedBorder: _border(AppColors.brandMaroon),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}

class MarnPhoneNumberInput extends StatelessWidget {
  const MarnPhoneNumberInput({
    super.key,
    required this.countryCode,
    required this.phoneController,
    this.onCountryTap,
  });

  final String countryCode;
  final TextEditingController phoneController;
  final VoidCallback? onCountryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone',
          style: AppTypography.heading5(
            ProfileDesignTokens.text,
          ).copyWith(fontSize: 21.sp, fontWeight: FontWeight.w800, height: 1.2),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            InkWell(
              onTap: onCountryTap,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: 112.w,
                height: 66.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.baseWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ProfileDesignTokens.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      countryCode,
                      style: AppTypography.heading4(
                        ProfileDesignTokens.text,
                      ).copyWith(fontSize: 23.sp, fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.brandMaroon,
                      size: 28.w,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: SizedBox(
                height: 66.h,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: AppTypography.heading4(
                    ProfileDesignTokens.text,
                  ).copyWith(fontSize: 23.sp, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.baseWhite,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    border: _border(ProfileDesignTokens.border),
                    enabledBorder: _border(ProfileDesignTokens.border),
                    focusedBorder: _border(AppColors.brandMaroon),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
