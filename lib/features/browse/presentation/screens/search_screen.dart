import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/browse/logic/search_cubit.dart';
import 'package:marn/routing/app_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return MarnPageScaffold(
      showBackButton: true,
      title: strings.searchTitle,
      subtitle: strings.searchSubtitle,
      child: Column(
        children: [
          MarnSearchField(
            hintText: strings.searchHint,
            onChanged: context.read<SearchCubit>().queryChanged,
            onSubmitted: (query) =>
                context.push('${AppRouter.searchResults}?q=$query'),
          ),
          SizedBox(height: 18.h),
          MarnActionRow(
            title: strings.recentSearch,
            subtitle: strings.recentSearchSubtitle,
            icon: Icons.history_rounded,
            onTap: () =>
                context.push('${AppRouter.searchResults}?q=housemaids'),
          ),
          SizedBox(height: 12.h),
          MarnActionRow(
            title: strings.suggestedSearch,
            subtitle: strings.suggestedSearchSubtitle,
            icon: Icons.auto_awesome_rounded,
            onTap: () => context.push('${AppRouter.searchResults}?q=events'),
          ),
        ],
      ),
    );
  }
}
