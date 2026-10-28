import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/home/data/models/home_models.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({super.key, required this.listing, this.onTap});

  final MarketplaceListing listing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: MarnCardSurface(
          borderRadius: 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.primary50,
                    child: const Icon(
                      Icons.person_search_rounded,
                      color: AppColors.primary600,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing.title,
                          style: AppTypography.paragraph2(
                            AppColors.baseDark,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '${listing.category} • ${listing.location}',
                          style: AppTypography.paragraph4(AppColors.gray500),
                        ),
                      ],
                    ),
                  ),
                  MarnPill(label: listing.priceLabel),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                listing.description,
                style: AppTypography.paragraph3(
                  AppColors.gray600,
                ).copyWith(height: 1.45),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppColors.warning500),
                  SizedBox(width: 4.w),
                  Text(
                    listing.rating.toStringAsFixed(1),
                    style: AppTypography.paragraph3(AppColors.baseDark),
                  ),
                  const Spacer(),
                  if (listing.isFeatured)
                    const MarnPill(
                      label: 'Featured',
                      color: AppColors.warning600,
                      backgroundColor: AppColors.warning50,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
