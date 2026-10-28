import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/payment/data/models/payment_models.dart';
import 'package:marn/features/payment/logic/payment_cubit.dart';

class PaymentCheckoutScreen extends StatelessWidget {
  const PaymentCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final strings = context.strings;
        final summary = state.summary;
        return MarnPageScaffold(
          showBackButton: true,
          title: state.status == PaymentStatus.paid
              ? strings.paymentComplete
              : strings.checkout,
          subtitle: strings.paymentSubtitle,
          child: MarnStateView(
            isLoading: state.status == PaymentStatus.loading,
            child: Column(
              children: [
                state.status == PaymentStatus.paid
                    ? MarnIllustratedPanel(
                        title: strings.paymentComplete,
                        subtitle: strings.totalDueIncludingFee,
                        illustrationAsset: MarnIllustrationAssets.done,
                      )
                    : MarnHeroPanel(
                        title: summary?.total ?? '',
                        subtitle: strings.totalDueIncludingFee,
                        icon: Icons.payments_rounded,
                      ),
                SizedBox(height: 14.h),
                for (final method
                    in summary?.methods ?? const <PaymentMethod>[])
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnActionRow(
                      title: strings.paymentMethodTitle(
                        method.id,
                        method.title,
                      ),
                      subtitle: strings.paymentMethodSubtitle(
                        method.id,
                        method.subtitle,
                      ),
                      icon: Icons.credit_card_rounded,
                      trailing: Icon(
                        state.selectedMethodId == method.id
                            ? Icons.check_circle_rounded
                            : Icons.circle_outlined,
                      ),
                      onTap: () =>
                          context.read<PaymentCubit>().selectMethod(method.id),
                    ),
                  ),
                SizedBox(height: 12.h),
                MarnActionRow(
                  title: summary?.amount ?? '',
                  subtitle: strings.serviceAmount,
                  icon: Icons.receipt_long_rounded,
                ),
                SizedBox(height: 12.h),
                MarnActionRow(
                  title: summary?.fee ?? '',
                  subtitle: strings.marnServiceFee,
                  icon: Icons.price_check_rounded,
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.status == PaymentStatus.paid
                        ? null
                        : context.read<PaymentCubit>().pay,
                    child: Text(
                      state.status == PaymentStatus.paid
                          ? strings.paid
                          : strings.payAmount(summary?.total ?? ''),
                    ),
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
