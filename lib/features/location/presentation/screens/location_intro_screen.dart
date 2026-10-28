import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/routing/app_router.dart';

class LocationIntroScreen extends StatelessWidget {
  const LocationIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return MarnPageScaffold(
      title: strings.setLocation,
      subtitle: strings.setLocationSubtitle,
      child: Column(
        children: [
          Image.asset(
            MarnIllustrationAssets.maps,
            height: 220.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 18.h),
          MarnActionRow(
            title: strings.useCurrentLocation,
            subtitle: strings.useCurrentLocationSubtitle,
            icon: Icons.my_location_rounded,
            onTap: () => context.push(AppRouter.locationCurrent),
          ),
          SizedBox(height: 12.h),
          MarnActionRow(
            title: strings.chooseOnMap,
            subtitle: strings.chooseOnMapSubtitle,
            icon: Icons.map_rounded,
            onTap: () => context.push(AppRouter.locationManual),
          ),
          SizedBox(height: 18.h),
          TextButton(
            onPressed: () => context.go(AppRouter.home),
            child: Text(strings.skipForNow),
          ),
        ],
      ),
    );
  }
}
