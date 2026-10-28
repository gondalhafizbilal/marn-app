import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/profile/logic/profile_cubit.dart';
import 'package:marn/routing/app_router.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          showBackButton: true,
          title: strings.myAds,
          subtitle: strings.myAdsPageSubtitle,
          trailing: IconButton(
            onPressed: () => context.push(AppRouter.adNew),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          child: MarnStateView(
            isLoading: state.status == ProfileStatus.loading,
            emptyMessage: state.ads.isEmpty ? strings.noAdsYet : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                for (final ad in state.ads)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnActionRow(
                      title: ad.title,
                      subtitle: strings.adViews(ad.status, ad.views),
                      icon: Icons.campaign_rounded,
                      onTap: () => context.push(AppRouter.adDetailPath(ad.id)),
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
