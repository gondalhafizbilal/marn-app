import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/routing/app_router.dart';

class RequestSuccessScreen extends StatelessWidget {
  const RequestSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return MarnPageScaffold(
      showBackButton: true,
      title: strings.requestSubmitted,
      subtitle: strings.requestSubmittedSubtitle,
      child: Column(
        children: [
          MarnIllustratedPanel(
            title: strings.matchingProviders,
            subtitle: strings.matchingProvidersSubtitle,
            illustrationAsset: MarnIllustrationAssets.success,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.go(AppRouter.requests),
              child: Text(strings.backToRequests),
            ),
          ),
        ],
      ),
    );
  }
}
