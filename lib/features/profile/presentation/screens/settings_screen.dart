import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _showDeleteAccountDialog(BuildContext context) {
    final strings = context.strings;

    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.baseWhite,
          contentPadding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 8.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MarnIllustration(
                MarnIllustrationAssets.delete,
                height: 150.h,
                semanticLabel: strings.deleteAccount,
              ),
              SizedBox(height: 12.h),
              Text(
                strings.deleteAccount,
                textAlign: TextAlign.center,
                style: AppTypography.heading5(
                  AppColors.baseDark,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 8.h),
              Text(
                strings.deleteAccountSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.paragraph3(
                  AppColors.gray600,
                ).copyWith(height: 1.45),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandMaroon,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(strings.deleteAccount),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return MarnPageScaffold(
      showBackButton: true,
      title: strings.settings,
      subtitle: strings.settingsPageSubtitle,
      child: Column(
        children: [
          MarnActionRow(
            title: strings.notificationSettings,
            subtitle: strings.notificationSettingsSubtitle,
            icon: Icons.notifications_none_rounded,
          ),
          SizedBox(height: 12.h),
          MarnActionRow(
            title: strings.changePassword,
            subtitle: strings.changePasswordSubtitle,
            icon: Icons.lock_outline_rounded,
          ),
          SizedBox(height: 12.h),
          MarnActionRow(
            title: strings.deleteAccount,
            subtitle: strings.deleteAccountSubtitle,
            icon: Icons.delete_outline_rounded,
            onTap: () => _showDeleteAccountDialog(context),
          ),
        ],
      ),
    );
  }
}
