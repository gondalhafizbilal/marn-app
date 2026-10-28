import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/home/logic/home_detail_cubit.dart';
import 'package:marn/features/wishlist/data/repositories/wishlist_repository.dart';
import 'package:marn/routing/app_router.dart';

class IndividualDetailScreen extends StatefulWidget {
  const IndividualDetailScreen({super.key});

  @override
  State<IndividualDetailScreen> createState() => _IndividualDetailScreenState();
}

class _IndividualDetailScreenState extends State<IndividualDetailScreen> {
  var _isSaving = false;
  final _savedIds = <String>{};

  Future<void> _saveToWishlist(MarketplaceListing listing) async {
    setState(() => _isSaving = true);
    final savedItem = await sl<WishlistRepository>().saveProfile(listing);

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
      _savedIds.add(listing.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${savedItem.title} added to wishlist.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDetailCubit, HomeDetailState>(
      builder: (context, state) {
        final listing = state.listing;
        final isSaved =
            listing != null &&
            (_savedIds.contains(listing.id) ||
                sl<WishlistRepository>().isProfileSaved(listing.id));

        return MarnPageScaffold(
          showBackButton: true,
          title: listing?.title ?? 'Individual profile',
          subtitle: listing?.category ?? 'Loading profile details.',
          child: MarnStateView(
            isLoading: state.status == DetailStatus.loading,
            emptyMessage: listing == null ? 'Profile not found.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: listing?.priceLabel ?? '',
                  subtitle: listing?.description ?? '',
                  icon: Icons.verified_user_rounded,
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    MarnMetricTile(
                      value: listing?.rating.toStringAsFixed(1) ?? '-',
                      label: 'Rating',
                      icon: Icons.star_rounded,
                    ),
                    SizedBox(width: 10.w),
                    const MarnMetricTile(
                      value: '32',
                      label: 'Jobs',
                      icon: Icons.task_alt_rounded,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: listing == null || _isSaving || isSaved
                        ? null
                        : () => _saveToWishlist(listing),
                    icon: MarnAssetIcon(
                      MarnIconAssets.heartFilled,
                      color: isSaved
                          ? AppColors.brandMaroon
                          : AppColors.gray400,
                    ),
                    label: Text(
                      isSaved
                          ? 'Saved to wishlist'
                          : _isSaving
                          ? 'Saving...'
                          : 'Add to wishlist',
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.push(AppRouter.booking),
                    child: const Text('Request booking'),
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(
                    AppRouter.reviewListPath(listing?.id ?? 'worker-1'),
                  ),
                  child: const Text('Read reviews'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
