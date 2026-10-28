import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/profile/data/models/profile_models.dart';
import 'package:marn/features/profile/logic/profile_cubit.dart';
import 'package:marn/features/profile/presentation/widgets/profile_design_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  var _countryCode = '+974';
  var _didHydrate = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _hydrate(ProfileSummary profile) {
    if (_didHydrate) {
      return;
    }

    _nameController.text = 'Abdulrahman Al-Marri';
    _emailController.text = profile.email;
    final compactPhone = profile.phone.replaceAll(' ', '');
    if (compactPhone.startsWith('+974')) {
      _countryCode = '+974';
      _phoneController.text = _formatLocalPhone(compactPhone.substring(4));
    } else {
      _phoneController.text = profile.phone;
    }
    _didHydrate = true;
  }

  String _formatLocalPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 4) {
      return digits;
    }
    return '${digits.substring(0, 4)} ${digits.substring(4)}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
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
                child: const MarnEmptyState(
                  message: 'Profile not loaded.',
                  illustrationAsset: MarnIllustrationAssets.oops,
                ),
              ),
            ),
          );
        }

        _hydrate(profile);

        return Scaffold(
          backgroundColor: ProfileDesignTokens.background,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 22.h, 30.w, 44.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const MarnProfileHeaderBar(
                      title: 'Edit Profile',
                      showBackButton: true,
                    ),
                    SizedBox(height: 56.h),
                    Center(
                      child: MarnProfileAvatar(
                        asset: profile.avatarAsset,
                        size: 132,
                        badgeSize: 42,
                      ),
                    ),
                    SizedBox(height: 84.h),
                    MarnEditProfileInput(
                      label: 'Full Name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 26.h),
                    MarnEditProfileInput(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 26.h),
                    MarnPhoneNumberInput(
                      countryCode: _countryCode,
                      phoneController: _phoneController,
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      height: 66.h,
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.brandMaroon,
                          foregroundColor: AppColors.baseWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Save Change',
                          style: AppTypography.heading4(AppColors.baseWhite)
                              .copyWith(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
