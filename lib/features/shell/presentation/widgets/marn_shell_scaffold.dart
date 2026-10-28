import 'package:flutter/material.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';

class MarnShellScaffold extends StatelessWidget {
  const MarnShellScaffold({
    super.key,
    required this.index,
    required this.onTap,
    required this.onAssistantTap,
    required this.child,
  });

  final int index;
  final ValueChanged<int> onTap;
  final VoidCallback onAssistantTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: AppColors.brandBeige,
      body: Stack(
        children: [
          Positioned.fill(child: child),
          if (index == 0)
            Positioned(
              right: 22,
              bottom: 23,
              child: InkWell(
                onTap: onAssistantTap,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.fromLTRB(18, 0, 14, 0),
                  decoration: BoxDecoration(
                    color: AppColors.brandMaroon,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.baseBlack.withValues(alpha: .18),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        strings.aiChatbot,
                        style: AppTypography.paragraph2(
                          AppColors.baseWhite,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.baseWhite,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.more_horiz_rounded,
                          color: AppColors.baseWhite,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _MarnBottomNavigationBar(index: index, onTap: onTap),
    );
  }
}

class _MarnBottomNavigationBar extends StatelessWidget {
  const _MarnBottomNavigationBar({required this.index, required this.onTap});

  final int index;
  final ValueChanged<int> onTap;

  static const _selectedColor = Color(0xFF7C0A23);
  static const _unselectedColor = Color(0xFFA9A29D);

  static const _items = [
    _MarnNavItemData(
      labelKey: 'home',
      iconAsset: 'assets/icons/bottom_nav/home.png',
      selectedIconAsset: 'assets/icons/bottom_nav/home_selected.png',
    ),
    _MarnNavItemData(
      labelKey: 'wishlist',
      iconAsset: 'assets/icons/bottom_nav/wishlist.png',
      selectedIconAsset: 'assets/icons/bottom_nav/wishlist_selected.png',
    ),
    _MarnNavItemData(
      labelKey: 'requests',
      iconAsset: 'assets/icons/bottom_nav/requests.png',
      selectedIconAsset: 'assets/icons/bottom_nav/requests_selected.png',
    ),
    _MarnNavItemData(
      labelKey: 'postAd',
      iconAsset: 'assets/icons/bottom_nav/post_ad.png',
      selectedIconAsset: 'assets/icons/bottom_nav/post_ad_selected.png',
    ),
    _MarnNavItemData(
      labelKey: 'profile',
      iconAsset: 'assets/icons/bottom_nav/profile.png',
      selectedIconAsset: 'assets/icons/bottom_nav/profile_selected.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / _items.length;
        final scale = (constraints.maxWidth / 375).clamp(.9, 1.08);
        final indicatorWidth = 28 * scale;
        final indicatorLeft =
            (itemWidth * index) + ((itemWidth - indicatorWidth) / 2);

        return Container(
          height: 86 * scale,
          decoration: const BoxDecoration(
            color: Color(0xFFFAFAF9),
            border: Border(top: BorderSide(color: Color(0xFFE0D8CF))),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                top: 0,
                left: indicatorLeft,
                child: Container(
                  width: indicatorWidth,
                  height: 3 * scale,
                  color: _selectedColor,
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < _items.length; i++)
                    Expanded(
                      child: _MarnBottomNavigationItem(
                        item: _items[i],
                        selected: i == index,
                        scale: scale,
                        selectedColor: _selectedColor,
                        unselectedColor: _unselectedColor,
                        onTap: () => onTap(i),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MarnBottomNavigationItem extends StatelessWidget {
  const _MarnBottomNavigationItem({
    required this.item,
    required this.selected,
    required this.scale,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final _MarnNavItemData item;
  final bool selected;
  final double scale;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? selectedColor : unselectedColor;

    return SizedBox.expand(
      child: InkResponse(
        onTap: onTap,
        radius: 28 * scale,
        child: Padding(
          padding: EdgeInsets.only(top: 22 * scale, bottom: 10 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MarnAssetIcon(
                selected ? item.selectedIconAsset : item.iconAsset,
                size: 24 * scale,
              ),
              SizedBox(height: 5 * scale),
              SizedBox(
                width: 64 * scale,
                height: 15 * scale,
                child: Text(
                  item.localizedLabel(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.label5(color).copyWith(
                    fontSize: 10 * scale,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarnNavItemData {
  const _MarnNavItemData({
    required this.labelKey,
    required this.iconAsset,
    required this.selectedIconAsset,
  });

  final String labelKey;
  final String iconAsset;
  final String selectedIconAsset;

  String localizedLabel(BuildContext context) {
    final strings = context.strings;
    return switch (labelKey) {
      'home' => strings.navHome,
      'wishlist' => strings.navWishlist,
      'requests' => strings.navRequests,
      'postAd' => strings.navPostAd,
      'profile' => strings.navProfile,
      _ => labelKey,
    };
  }
}
