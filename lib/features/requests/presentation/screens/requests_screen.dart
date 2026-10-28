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

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          title: strings.requests,
          subtitle: strings.requestsSubtitle,
          trailing: IconButton(
            onPressed: () => context.push(AppRouter.requestSubmit),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          child: MarnStateView(
            isLoading: state.status == RequestsStatus.loading,
            emptyMessage: state.requests.isEmpty ? strings.noRequestsYet : null,
            emptyIllustrationAsset: MarnIllustrationAssets.success,
            child: Column(
              children: [
                for (final request in state.requests)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnActionRow(
                      title: request.title,
                      subtitle:
                          '${request.provider} • ${request.scheduledFor} • ${request.status}',
                      icon: Icons.receipt_long_rounded,
                      onTap: () => context.push(AppRouter.requestPreview),
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
