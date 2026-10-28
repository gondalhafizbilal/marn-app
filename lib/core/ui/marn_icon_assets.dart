import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarnIconAssets {
  static const search = 'assets/icons/app/search.svg';
  static const filter = 'assets/icons/app/filter.svg';
  static const arrowLeft = 'assets/icons/app/arrow_left.png';
  static const gridView = 'assets/icons/app/grid_view.png';
  static const singleView = 'assets/icons/app/single_view.png';
  static const category = 'assets/icons/app/category.svg';
  static const heartFilled = 'assets/icons/app/heart_filled.svg';
  static const location = 'assets/icons/app/location.png';
  static const profileEdit = 'assets/icons/app/profile_edit.png';
  static const profileMyAds = 'assets/icons/app/profile_my_ads.png';
  static const profileAbout = 'assets/icons/app/profile_about.png';
  static const profileNotifications =
      'assets/icons/app/profile_notifications.png';
  static const profileDelete = 'assets/icons/app/profile_delete.png';
}

class MarnAssetIcon extends StatelessWidget {
  const MarnAssetIcon(
    this.asset, {
    super.key,
    this.size = 24,
    this.color,
    this.fit = BoxFit.contain,
  });

  final String asset;
  final double size;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (asset.endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: size,
        height: size,
        fit: fit,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }

    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: fit,
      color: color,
    );
  }
}
