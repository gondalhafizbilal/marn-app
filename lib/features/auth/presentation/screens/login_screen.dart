import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/auth/logic/auth_status.dart';
import 'package:marn/features/auth/logic/login_cubit.dart';
import 'package:marn/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:marn/routing/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.push(AppRouter.verify);
        }
      },
      builder: (context, state) {
        final strings = context.strings;

        return AuthScaffold(
          title: strings.loginTitle,
          subtitle: strings.loginSubtitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthPhoneField(
                countryCode: state.countryCode,
                initialValue: state.phoneNumber,
                onCountryChanged: context.read<LoginCubit>().countryCodeChanged,
                onChanged: context.read<LoginCubit>().phoneChanged,
              ),
              SizedBox(height: 11.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.gray400,
                    fontSize: 16.sp,
                    height: 1.43,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'By signing in or creating an account, you agree with our\n',
                    ),
                    TextSpan(
                      text: strings.termsAndConditions,
                      style: const TextStyle(
                        color: AppColors.brandMaroon,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.brandMaroon,
                      ),
                    ),
                  ],
                ),
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
              SizedBox(height: 33.h),
              AuthPrimaryButton(
                onPressed: state.status == AuthStatus.submitting
                    ? null
                    : context.read<LoginCubit>().submit,
                label: state.status == AuthStatus.submitting
                    ? strings.sending
                    : strings.signIn,
              ),
              SizedBox(height: 30.h),
              Text(
                strings.or,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gray900,
                  fontSize: 16.sp,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 26.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthSocialButton.apple(),
                  SizedBox(width: 18),
                  AuthSocialButton.google(),
                ],
              ),
              SizedBox(height: 18.h),
              TextButton(
                onPressed: () => context.push(AppRouter.register),
                child: Text(strings.createNewAccount),
              ),
            ],
          ),
        );
      },
    );
  }
}
