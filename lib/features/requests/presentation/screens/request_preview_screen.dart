import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/requests/logic/requests_cubit.dart';
import 'package:marn/routing/app_router.dart';

class RequestPreviewScreen extends StatelessWidget {
  const RequestPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        final strings = context.strings;
        final request = state.preview;
        return MarnPageScaffold(
          showBackButton: true,
          title: request?.title ?? strings.requestPreview,
          subtitle: request?.status ?? strings.reviewRequestDetails,
          child: MarnStateView(
            isLoading: state.status == RequestsStatus.loading,
            emptyMessage: request == null
                ? strings.requestPreviewNotFound
                : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: Column(
              children: [
                MarnHeroPanel(
                  title: request?.provider ?? '',
                  subtitle: request?.scheduledFor ?? '',
                  icon: Icons.assignment_turned_in_rounded,
                ),
                SizedBox(height: 14.h),
                MarnActionRow(
                  title: strings.continueToPayment,
                  subtitle: strings.reserveProviderSubtitle,
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
