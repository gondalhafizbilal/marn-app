import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/auth/logic/auth_status.dart';
import 'package:marn/features/auth/logic/register_cubit.dart';
import 'package:marn/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:marn/routing/app_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.go(AppRouter.login);
        }
      },
      builder: (context, state) {
        final strings = context.strings;

        return AuthScaffold(
          title: strings.registerTitle,
          subtitle: strings.registerSubtitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                label: strings.name,
                hint: strings.enterYourName,
                initialValue: state.fullName,
                onChanged: context.read<RegisterCubit>().fullNameChanged,
              ),
              SizedBox(height: 19.h),
              AuthTextField(
                label: strings.emailOptional,
                hint: 'brooklynsimmons@gmail.com',
                initialValue: state.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: context.read<RegisterCubit>().emailChanged,
              ),
              SizedBox(height: 19.h),
              AuthPhoneField(
                label: strings.contactNumber,
                countryCode: state.countryCode,
                initialValue: state.phoneNumber,
                onCountryChanged: context
                    .read<RegisterCubit>()
                    .countryCodeChanged,
                onChanged: context.read<RegisterCubit>().phoneChanged,
              ),
              SizedBox(height: 19.h),
              AuthSelectField(label: strings.gender, value: strings.maleFemale),
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
              SizedBox(height: 35.h),
              AuthPrimaryButton(
                onPressed: state.status == AuthStatus.submitting
                    ? null
                    : context.read<RegisterCubit>().submit,
                label: state.status == AuthStatus.submitting
                    ? strings.creating
                    : strings.save,
              ),
            ],
          ),
        );
      },
    );
  }
}
