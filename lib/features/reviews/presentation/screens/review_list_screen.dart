import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/reviews/logic/reviews_cubit.dart';
import 'package:marn/routing/app_router.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        return MarnPageScaffold(
          showBackButton: true,
          title: 'Reviews',
          subtitle: 'Provider feedback from completed requests.',
          trailing: IconButton(
            onPressed: () => context.push(AppRouter.reviewWrite),
            icon: const Icon(Icons.rate_review_outlined),
          ),
          child: MarnStateView(
            isLoading: state.isLoading,
            emptyMessage: state.reviews.isEmpty ? 'No reviews yet.' : null,
            emptyIllustrationAsset: MarnIllustrationAssets.success,
            child: Column(
              children: [
                for (final review in state.reviews)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MarnCardSurface(
                      borderRadius: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                review.author,
                                style: AppTypography.paragraph2(
                                  AppColors.baseDark,
                                ).copyWith(fontWeight: FontWeight.w800),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: AppColors.warning500,
                                    size: 18,
                                  ),
                                  Text('${review.rating}'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            review.body,
                            style: AppTypography.paragraph3(AppColors.gray600),
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
