import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/auth/logic/auth_status.dart';
import 'package:marn/features/auth/logic/otp_cubit.dart';
import 'package:marn/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:marn/routing/app_router.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.go(AppRouter.home);
        }
      },
      builder: (context, state) {
        final strings = context.strings;

        return AuthScaffold(
          title: strings.verifyTitle,
          subtitle: strings.verifySubtitle,
          subtitleHighlight: 'Whatsapp.',
          showLanguageButton: false,
          contentGap: 25.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthOtpCodeField(
                value: state.code,
                onChanged: context.read<OtpCubit>().codeChanged,
              ),
              if (state.errorMessage != null) ...[
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: AppColors.error600),
                  ),
                ),
              ],
              SizedBox(height: 54.h),
              Text(
                strings.dontReceiveCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gray900,
                  fontSize: 16.sp,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error400,
                  textStyle: TextStyle(fontSize: 16.sp, height: 1.25),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(strings.resendCode),
              ),
              SizedBox(height: 44.h),
              AuthPrimaryButton(
                onPressed: state.status == AuthStatus.submitting
                    ? null
                    : context.read<OtpCubit>().verify,
                label: state.status == AuthStatus.submitting
                    ? strings.verifying
                    : strings.verify,
              ),
            ],
          ),
        );
      },
    );
  }
}
