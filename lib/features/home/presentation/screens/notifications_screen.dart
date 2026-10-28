import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/home/logic/home_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return MarnPageScaffold(
          showBackButton: true,
          title: 'Notifications',
          subtitle: 'Request updates, payment receipts, and account activity.',
          child: MarnStateView(
            isLoading: state.status == HomeStatus.loading,
            emptyMessage: state.notifications.isEmpty
                ? 'No notifications yet.'
                : null,
            emptyIllustrationAsset: MarnIllustrationAssets.notifications,
            child: Column(
              children: [
                for (final item in state.notifications)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnCardSurface(
                      borderRadius: 18,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: item.isUnread
                                ? AppColors.primary50
                                : AppColors.gray100,
                            child: Icon(
                              item.isUnread
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_none_rounded,
                              color: AppColors.primary600,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: AppTypography.paragraph2(
                                    AppColors.baseDark,
                                  ).copyWith(fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item.body,
                                  style: AppTypography.paragraph4(
                                    AppColors.gray500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            item.timeAgo,
                            style: AppTypography.paragraph4(AppColors.gray400),
                          ),
                        ],
                      ),
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
