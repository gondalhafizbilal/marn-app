import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/home/data/models/home_models.dart';

class AgencyCard extends StatelessWidget {
  const AgencyCard({super.key, required this.agency, this.onTap});

  final AgencySummary agency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MarnCardSurface(
      borderRadius: 22,
      padding: EdgeInsets.all(16.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.primary600,
              child: Text(
                agency.name.substring(0, 1),
                style: const TextStyle(color: AppColors.baseWhite),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agency.name,
                    style: AppTypography.paragraph2(
                      AppColors.baseDark,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${agency.specialty} • ${agency.location}',
                    style: AppTypography.paragraph4(AppColors.gray500),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  agency.rating.toStringAsFixed(1),
                  style: AppTypography.paragraph2(
                    AppColors.baseDark,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  '${agency.openRequests} requests',
                  style: AppTypography.paragraph4(AppColors.gray500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
