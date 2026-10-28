import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/browse/data/models/browse_models.dart';
import 'package:marn/features/browse/logic/browse_cubit.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/home/presentation/widgets/listing_card.dart';
import 'package:marn/routing/app_router.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseCubit, BrowseState>(
      builder: (context, state) {
        final strings = context.strings;
        final dashboard = state.dashboard;
        return MarnPageScaffold(
          title: strings.browse,
          subtitle: strings.browseSubtitle,
          child: MarnStateView(
            isLoading: state.status == BrowseStatus.loading,
            emptyMessage: dashboard == null ? strings.noCategoriesLoaded : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarnSearchField(
                  hintText: strings.searchServicesHint,
                  onSubmitted: (query) =>
                      context.push('${AppRouter.searchResults}?q=$query'),
                ),
                SizedBox(height: 14.h),
                MarnActionRow(
                  title: strings.filters,
                  subtitle: strings.filtersSubtitle,
                  icon: Icons.tune_rounded,
                  iconAsset: MarnIconAssets.filter,
                  onTap: () => context.push(AppRouter.filters),
                ),
                SizedBox(height: 22.h),
                MarnSectionTitle(title: strings.categories),
                SizedBox(height: 12.h),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.35,
                  children: [
                    for (final category
                        in dashboard?.categories ?? const <BrowseCategory>[])
                      _CategoryCard(category: category),
                  ],
                ),
                SizedBox(height: 22.h),
                MarnSectionTitle(title: strings.recommended),
                SizedBox(height: 12.h),
                for (final listing
                    in dashboard?.recommendedListings ??
                        const <MarketplaceListing>[])
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ListingCard(
                      listing: listing,
                      onTap: () =>
                          context.push(AppRouter.adDetailPath(listing.id)),
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final BrowseCategory category;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return MarnCardSurface(
      borderRadius: 18,
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarnAssetIcon(
            MarnIconAssets.category,
            size: 24,
            color: AppColors.primary600,
          ),
          const Spacer(),
          Text(
            strings.browseCategoryTitle(category.id, category.title),
            style: AppTypography.paragraph2(
              AppColors.baseDark,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 4.h),
          Text(
            strings.browseCategorySubtitle(category.id, category.subtitle),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.paragraph4(AppColors.gray500),
          ),
        ],
      ),
    );
  }
}
