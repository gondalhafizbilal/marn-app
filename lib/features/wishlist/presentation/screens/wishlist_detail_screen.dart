import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/features/wishlist/logic/wishlist_cubit.dart';
import 'package:marn/routing/app_router.dart';

class WishlistDetailScreen extends StatelessWidget {
  const WishlistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final item = state.selected;
        return MarnPageScaffold(
          showBackButton: true,
          title: item?.title ?? 'Saved item',
          subtitle: item?.primaryMeta ?? 'Loading saved item.',
          child: MarnStateView(
            isLoading: state.status == WishlistStatus.loading,
            emptyMessage: item == null ? 'Saved item not found.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: item?.priceLabel ?? '',
                  subtitle: item == null
                      ? ''
                      : '${item.primaryMeta}\n${item.locationLabel}',
                  icon: item?.isProfile == true
                      ? Icons.person_rounded
                      : Icons.favorite_rounded,
                  iconAsset: item?.isProfile == true
                      ? null
                      : MarnIconAssets.heartFilled,
                ),
                SizedBox(height: 14.h),
                MarnActionRow(
                  title: 'Open details',
                  subtitle: 'View the full profile and availability.',
                  icon: Icons.open_in_new_rounded,
                  onTap: () => context.push(AppRouter.adDetailPath('ad-1')),
                ),
                SizedBox(height: 12.h),
                MarnActionRow(
                  title: 'Start chat',
                  subtitle: 'Ask questions before booking.',
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () => context.push(AppRouter.chatbot),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
