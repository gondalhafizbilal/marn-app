import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/features/home/logic/home_detail_cubit.dart';
import 'package:marn/routing/app_router.dart';

class AdDetailScreen extends StatelessWidget {
  const AdDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDetailCubit, HomeDetailState>(
      builder: (context, state) {
        final listing = state.listing;
        return MarnPageScaffold(
          showBackButton: true,
          title: listing?.title ?? 'Advertisement',
          subtitle: listing?.location ?? 'Loading ad details.',
          child: MarnStateView(
            isLoading: state.status == DetailStatus.loading,
            emptyMessage: listing == null ? 'Ad not found.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: listing?.priceLabel ?? '',
                  subtitle: listing?.description ?? '',
                  icon: Icons.campaign_rounded,
                ),
                SizedBox(height: 16.h),
                MarnActionRow(
                  title: 'Contact advertiser',
                  subtitle: 'Open chat and ask for availability.',
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () => context.push(AppRouter.chatbot),
                ),
                SizedBox(height: 12.h),
                MarnActionRow(
                  title: 'Reserve and pay',
                  subtitle: 'Continue to checkout for this service.',
                  icon: Icons.payments_outlined,
                  onTap: () => context.push(AppRouter.payment),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
