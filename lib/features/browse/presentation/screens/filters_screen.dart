import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/browse/logic/filters_cubit.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          showBackButton: true,
          title: strings.filters,
          subtitle: strings.filtersPageSubtitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  for (final option in state.options)
                    FilterChip(
                      label: Text(
                        strings.filterOption(option.id, option.label),
                      ),
                      selected: option.isSelected,
                      selectedColor: AppColors.primary50,
                      checkmarkColor: AppColors.primary600,
                      onSelected: (_) =>
                          context.read<FiltersCubit>().toggle(option.id),
                    ),
                ],
              ),
              SizedBox(height: 28.h),
              FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(strings.applyFilters),
              ),
            ],
          ),
        );
      },
    );
  }
}
