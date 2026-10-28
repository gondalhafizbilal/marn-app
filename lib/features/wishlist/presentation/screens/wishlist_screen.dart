import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/wishlist/data/models/wishlist_item.dart';
import 'package:marn/features/wishlist/logic/wishlist_cubit.dart';
import 'package:marn/routing/app_router.dart';

enum _WishlistViewMode { grid, single }

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  static const _categoryOptions = [
    'All',
    'Workers Agency',
    'Workers Profile',
    'Ads',
  ];

  _WishlistViewMode _viewMode = _WishlistViewMode.grid;
  String _query = '';
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showCategoryFilterSheet(
    List<String> categories,
    String selectedCategory,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.baseWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: AppTypography.heading5(
                    AppColors.baseDark,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 10.h),
                for (final category in categories)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(category),
                    trailing: Icon(
                      category == selectedCategory
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: category == selectedCategory
                          ? AppColors.brandMaroon
                          : AppColors.gray400,
                    ),
                    onTap: () {
                      setState(() => _selectedCategory = category);
                      Navigator.of(sheetContext).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<WishlistItem> _visibleItems(
    List<WishlistItem> items,
    String selectedCategory,
  ) {
    final query = _query.trim().toLowerCase();

    return items.where((item) {
      final matchesCategory = switch (selectedCategory) {
        'Workers Agency' => item.effectiveType == WishlistItemType.agency,
        'Workers Profile' => item.effectiveType == WishlistItemType.profile,
        'Ads' => item.effectiveType == WishlistItemType.ad,
        _ => true,
      };
      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.note.toLowerCase().contains(query) ||
          item.priceLabel.toLowerCase().contains(query) ||
          item.primaryMeta.toLowerCase().contains(query) ||
          item.locationLabel.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        const categories = _categoryOptions;
        final selectedCategory = categories.contains(_selectedCategory)
            ? _selectedCategory
            : 'All';
        final items = _visibleItems(state.items, selectedCategory);

        return MarnPageScaffold(
          showTopPadding: false,
          child: MarnStateView(
            isLoading: state.status == WishlistStatus.loading,
            emptyMessage: state.items.isEmpty ? 'No saved items yet.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.done,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _WishlistTopBar(title: 'Wishlist'),
                SizedBox(height: 28.h),
                MarnSearchField(
                  controller: _searchController,
                  hintText: 'Search',
                  onChanged: (value) => setState(() => _query = value),
                  onFilterTap: () =>
                      _showCategoryFilterSheet(categories, selectedCategory),
                  onClear: _query.isEmpty
                      ? null
                      : () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                ),
                SizedBox(height: 30.h),
                _WishlistCategoryChips(
                  categories: categories,
                  selectedCategory: selectedCategory,
                  onSelected: (category) =>
                      setState(() => _selectedCategory = category),
                ),
                SizedBox(height: 16.h),
                _WishlistToolbar(
                  itemCount: items.length,
                  onFiltersPressed: () =>
                      _showCategoryFilterSheet(categories, selectedCategory),
                  viewMode: _viewMode,
                  onModeChanged: (mode) => setState(() => _viewMode = mode),
                ),
                SizedBox(height: 18.h),
                if (items.isEmpty)
                  const MarnEmptyState(
                    message: 'No wishlist matches found.',
                    illustrationAsset: MarnIllustrationAssets.locationNotFound,
                  )
                else
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: _viewMode == _WishlistViewMode.grid
                        ? _WishlistGrid(
                            key: const ValueKey('wishlist-grid'),
                            items: items,
                          )
                        : _WishlistSingleList(
                            key: const ValueKey('wishlist-single'),
                            items: items,
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

class _WishlistTopBar extends StatelessWidget {
  const _WishlistTopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTypography.paragraph2(
            AppColors.baseDark,
          ).copyWith(fontWeight: FontWeight.w700, height: 24 / 16),
        ),
      ),
    );
  }
}

class _WishlistCategoryChips extends StatelessWidget {
  const _WishlistCategoryChips({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Material(
            color: isSelected ? AppColors.brandMaroon : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r),
            child: InkWell(
              onTap: () => onSelected(category),
              borderRadius: BorderRadius.circular(4.r),
              child: Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: AppColors.brandMaroon,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  category,
                  style: AppTypography.paragraph4(
                    isSelected ? AppColors.baseWhite : AppColors.brandMaroon,
                  ).copyWith(height: 18 / 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WishlistToolbar extends StatelessWidget {
  const _WishlistToolbar({
    required this.itemCount,
    required this.onFiltersPressed,
    required this.viewMode,
    required this.onModeChanged,
  });

  final int itemCount;
  final VoidCallback onFiltersPressed;
  final _WishlistViewMode viewMode;
  final ValueChanged<_WishlistViewMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: [
          SizedBox(
            width: 79.w,
            height: 30.h,
            child: OutlinedButton(
              onPressed: onFiltersPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.brandMaroon,
                side: const BorderSide(color: AppColors.brandMaroon),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                textStyle: AppTypography.paragraph4(
                  AppColors.brandMaroon,
                ).copyWith(height: 18 / 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Filters'),
                  SizedBox(width: 4.w),
                  MarnAssetIcon(
                    MarnIconAssets.filter,
                    size: 14.w,
                    color: AppColors.brandMaroon,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '$itemCount ads found',
            style: AppTypography.paragraph4(
              AppColors.brandMaroon,
            ).copyWith(height: 18 / 12),
          ),
          const Spacer(),
          _WishlistViewButton(
            tooltip: 'Grid view',
            asset: MarnIconAssets.gridView,
            isSelected: viewMode == _WishlistViewMode.grid,
            onTap: () => onModeChanged(_WishlistViewMode.grid),
          ),
          SizedBox(width: 14.w),
          _WishlistViewButton(
            tooltip: 'Single view',
            asset: MarnIconAssets.singleView,
            isSelected: viewMode == _WishlistViewMode.single,
            onTap: () => onModeChanged(_WishlistViewMode.single),
          ),
        ],
      ),
    );
  }
}

class _WishlistViewButton extends StatelessWidget {
  const _WishlistViewButton({
    required this.tooltip,
    required this.asset,
    required this.isSelected,
    required this.onTap,
  });

  final String tooltip;
  final String asset;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.brandMaroon : AppColors.gray400;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        selected: isSelected,
        label: tooltip,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: 24.w,
              height: 24.w,
              child: Center(
                child: MarnAssetIcon(asset, size: 24.w, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WishlistGrid extends StatelessWidget {
  const _WishlistGrid({super.key, required this.items});

  final List<WishlistItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        mainAxisExtent: 240.h,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        if (item.isProfile) {
          return _WishlistWorkerGridCard(item: item, index: index);
        }

        return _WishlistCard(item: item, index: index, isSingleView: false);
      },
    );
  }
}

class _WishlistWorkerGridCard extends StatelessWidget {
  const _WishlistWorkerGridCard({required this.item, required this.index});

  final WishlistItem item;
  final int index;

  static const _swatches = [
    Color(0xFF9D5B5B),
    Color(0xFF637A9F),
    Color(0xFF9C7560),
    Color(0xFF6F8B75),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.baseWhite,
      borderRadius: BorderRadius.circular(12.86.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRouter.wishlistItemPath(item.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160.h,
              width: double.infinity,
              child: _WishlistCardMedia(
                color: _swatches[index % _swatches.length],
                isSingleView: false,
                imageUrl: item.imageUrl,
                favoriteSize: 18.w,
              ),
            ),
            SizedBox(
              height: 80.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.paragraph3(
                        AppColors.baseBlack,
                      ).copyWith(fontWeight: FontWeight.w600, height: 18 / 14),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.primaryMeta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.label5(
                        const Color(0xFF1F2A37),
                      ).copyWith(height: 14 / 10),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        const MarnAssetIcon(MarnIconAssets.location, size: 12),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            item.locationLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.label5(
                              AppColors.grayModern400,
                            ).copyWith(height: 14 / 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistSingleList extends StatelessWidget {
  const _WishlistSingleList({super.key, required this.items});

  final List<WishlistItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < items.length; index++)
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _WishlistCard(
              item: items[index],
              index: index,
              isSingleView: true,
            ),
          ),
      ],
    );
  }
}

class _WishlistCard extends StatelessWidget {
  const _WishlistCard({
    required this.item,
    required this.index,
    required this.isSingleView,
  });

  final WishlistItem item;
  final int index;
  final bool isSingleView;

  static const _swatches = [
    Color(0xFF9D5B5B),
    Color(0xFF637A9F),
    Color(0xFF9C7560),
    Color(0xFF6F8B75),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.baseWhite,
      borderRadius: BorderRadius.circular(18.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRouter.wishlistItemPath(item.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: isSingleView ? 1.05 : .98,
              child: _WishlistCardMedia(
                color: _swatches[index % _swatches.length],
                isSingleView: isSingleView,
                imageUrl: item.imageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: isSingleView ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.heading5(AppColors.baseBlack).copyWith(
                      fontSize: isSingleView ? 22.sp : 16.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item.primaryMeta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.paragraph3(
                      AppColors.gray800,
                    ).copyWith(fontSize: isSingleView ? 15.sp : 13.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      MarnAssetIcon(
                        MarnIconAssets.location,
                        size: isSingleView ? 20.w : 17.w,
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          item.locationLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.paragraph3(
                            AppColors.gray400,
                          ).copyWith(fontSize: isSingleView ? 14.sp : 12.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistCardMedia extends StatelessWidget {
  const _WishlistCardMedia({
    required this.color,
    required this.isSingleView,
    this.imageUrl,
    this.favoriteSize,
  });

  final Color color;
  final bool isSingleView;
  final String? imageUrl;
  final double? favoriteSize;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    if (hasImage) {
      return Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => _WishlistPortraitFallback(
              color: color,
              isSingleView: isSingleView,
            ),
            errorWidget: (context, url, error) => _WishlistPortraitFallback(
              color: color,
              isSingleView: isSingleView,
            ),
          ),
          _WishlistFavoriteBadge(
            isSingleView: isSingleView,
            iconSize: favoriteSize,
          ),
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        _WishlistPortraitFallback(color: color, isSingleView: isSingleView),
        _WishlistFavoriteBadge(
          isSingleView: isSingleView,
          iconSize: favoriteSize,
        ),
      ],
    );
  }
}

class _WishlistPortraitFallback extends StatelessWidget {
  const _WishlistPortraitFallback({
    required this.color,
    required this.isSingleView,
  });

  final Color color;
  final bool isSingleView;

  @override
  Widget build(BuildContext context) {
    final background = Color.lerp(color, AppColors.baseWhite, .68)!;

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [background, AppColors.baseWhite],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Icon(
            Icons.person_rounded,
            size: isSingleView ? 190.w : 104.w,
            color: color.withValues(alpha: .42),
          ),
        ),
      ],
    );
  }
}

class _WishlistFavoriteBadge extends StatelessWidget {
  const _WishlistFavoriteBadge({required this.isSingleView, this.iconSize});

  final bool isSingleView;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 14.h,
      right: 14.w,
      child: Container(
        width: isSingleView ? 42.w : 34.w,
        height: isSingleView ? 42.w : 34.w,
        decoration: const BoxDecoration(
          color: AppColors.baseWhite,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: MarnAssetIcon(
            MarnIconAssets.heartFilled,
            color: AppColors.brandMaroon,
            size: iconSize ?? (isSingleView ? 23.w : 19.w),
          ),
        ),
      ),
    );
  }
}
