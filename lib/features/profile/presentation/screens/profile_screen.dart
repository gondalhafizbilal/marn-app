import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/profile/data/models/profile_models.dart';
import 'package:marn/features/profile/logic/profile_cubit.dart';
import 'package:marn/features/profile/presentation/widgets/profile_design_widgets.dart';
import 'package:marn/routing/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final strings = context.strings;
        final profile = state.profile;

        if (state.status == ProfileStatus.loading) {
          return const ColoredBox(
            color: ProfileDesignTokens.background,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (profile == null) {
          return ColoredBox(
            color: ProfileDesignTokens.background,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: MarnEmptyState(
                  message: strings.profileNotLoaded,
                  illustrationAsset: MarnIllustrationAssets.oops,
                ),
              ),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return ColoredBox(
              color: ProfileDesignTokens.surface,
              child: Column(
                children: [
                  Flexible(flex: 0, child: _ProfileTopPanel(profile: profile)),
                  Expanded(
                    child: _ProfileMenu(
                      minHeight: (constraints.maxHeight - 296.h).clamp(
                        420.0,
                        double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ProfileTopPanel extends StatelessWidget {
  const _ProfileTopPanel({required this.profile});

  final ProfileSummary profile;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocalizationsCubit>().state;
    final nextCode = locale.languageCode == 'ar' ? 'en' : 'ar';
    final label = locale.languageCode == 'ar' ? 'English' : 'العربية';

    return Container(
      height: 296.h,
      width: double.infinity,
      color: ProfileDesignTokens.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.w, 22.h, 30.w, 0),
          child: Column(
            children: [
              MarnProfileHeaderBar(
                title: 'Profile',
                trailing: TextButton(
                  onPressed: () =>
                      context.read<LocalizationsCubit>().setLanguage(nextCode),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.brandMaroon,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(80.w, 40.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    label,
                    style: AppTypography.heading5(AppColors.brandMaroon)
                        .copyWith(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 42.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MarnProfileAvatar(
                    asset: profile.avatarAsset,
                    size: 126,
                    badgeSize: 40,
                  ),
                  SizedBox(width: 34.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.heading4(
                                ProfileDesignTokens.text,
                              ).copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          profile.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.paragraph1(
                            ProfileDesignTokens.muted,
                          ).copyWith(fontSize: 19.sp, height: 1.15),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          profile.phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.paragraph1(
                            ProfileDesignTokens.muted,
                          ).copyWith(fontSize: 19.sp, height: 1.15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({required this.minHeight});

  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ProfileDesignTokens.surface,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              30.w,
              38.h,
              28.w,
              32.h + MediaQuery.paddingOf(context).bottom,
            ),
            child: Column(
              children: [
                MarnProfileMenuItem(
                  label: 'Edit Profile',
                  iconAsset: MarnIconAssets.profileEdit,
                  onTap: () => context.push(AppRouter.editProfile),
                ),
                MarnProfileMenuItem(
                  label: 'My Ads',
                  iconAsset: MarnIconAssets.profileMyAds,
                  onTap: () => context.push(AppRouter.ads),
                ),
                MarnProfileMenuItem(
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  onTap: () => context.push(AppRouter.profileSettings),
                ),
                MarnProfileMenuItem(
                  label: 'Notification',
                  iconAsset: MarnIconAssets.profileNotifications,
                  onTap: () => context.push(AppRouter.notifications),
                ),
                MarnProfileMenuItem(
                  label: 'About',
                  iconAsset: MarnIconAssets.profileAbout,
                  onTap: () => context.push(AppRouter.profileSettings),
                ),
                MarnProfileMenuItem(
                  label: 'Delete Account',
                  iconAsset: MarnIconAssets.profileDelete,
                  destructive: true,
                  showChevron: false,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
                SizedBox(height: 120.h),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFF756D),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 10.h,
                    ),
                  ),
                  child: Text(
                    'Sign Out',
                    style: AppTypography.heading5(
                      const Color(0xFFFF756D),
                    ).copyWith(fontSize: 23.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.baseWhite,
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete this account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
