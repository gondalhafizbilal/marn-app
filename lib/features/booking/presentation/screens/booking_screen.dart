import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/booking/logic/booking_cubit.dart';
import 'package:marn/routing/app_router.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final strings = context.strings;
        final quote = state.quote;
        return MarnPageScaffold(
          showBackButton: true,
          title: strings.booking,
          subtitle: strings.bookingSubtitle,
          child: MarnStateView(
            isLoading: quote == null,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: quote?.provider ?? '',
                  subtitle: quote?.service ?? '',
                  icon: Icons.calendar_month_rounded,
                ),
                SizedBox(height: 14.h),
                MarnActionRow(
                  title: quote?.dateRange ?? '',
                  subtitle: strings.selectedBookingDates,
                  icon: Icons.date_range_rounded,
                ),
                SizedBox(height: 12.h),
                MarnActionRow(
                  title: quote?.total ?? '',
                  subtitle: strings.estimatedTotal,
                  icon: Icons.payments_outlined,
                  onTap: () => context.push(AppRouter.payment),
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.push(AppRouter.payment),
                    child: Text(strings.continueToPayment),
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
