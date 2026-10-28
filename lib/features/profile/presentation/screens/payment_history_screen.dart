import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/profile/logic/profile_cubit.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          showBackButton: true,
          title: strings.paymentHistory,
          subtitle: strings.paymentHistorySubtitle,
          child: MarnStateView(
            isLoading: state.status == ProfileStatus.loading,
            emptyMessage: state.payments.isEmpty ? strings.noPaymentsYet : null,
            emptyIllustrationAsset: MarnIllustrationAssets.success,
            child: Column(
              children: [
                for (final payment in state.payments)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnActionRow(
                      title: payment.title,
                      subtitle: '${payment.amount} • ${payment.date}',
                      icon: Icons.receipt_long_rounded,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
