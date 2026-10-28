import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/features/home/logic/home_detail_cubit.dart';
import 'package:marn/routing/app_router.dart';

class AgencyDetailScreen extends StatelessWidget {
  const AgencyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDetailCubit, HomeDetailState>(
      builder: (context, state) {
        final agency = state.agency;
        return MarnPageScaffold(
          showBackButton: true,
          title: agency?.name ?? 'Agency profile',
          subtitle: agency?.specialty ?? 'Loading agency details.',
          child: MarnStateView(
            isLoading: state.status == DetailStatus.loading,
            emptyMessage: agency == null ? 'Agency not found.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: agency?.location ?? '',
                  subtitle:
                      'Verified agency profile with live requests, packages, and service history.',
                  icon: Icons.business_rounded,
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    MarnMetricTile(
                      value: agency?.rating.toStringAsFixed(1) ?? '-',
                      label: 'Rating',
                      icon: Icons.star_rounded,
                    ),
                    SizedBox(width: 10.w),
                    MarnMetricTile(
                      value: '${agency?.openRequests ?? 0}',
                      label: 'Open requests',
                      icon: Icons.assignment_rounded,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.push(AppRouter.requestSubmit),
                    child: const Text('Send request'),
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
