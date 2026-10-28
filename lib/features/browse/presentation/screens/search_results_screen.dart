import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/browse/logic/search_cubit.dart';
import 'package:marn/features/home/presentation/widgets/listing_card.dart';
import 'package:marn/routing/app_router.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          showBackButton: true,
          title: strings.searchResults,
          subtitle: state.query.isEmpty
              ? strings.allResults
              : strings.resultsFor(state.query),
          child: MarnStateView(
            isLoading: state.status == SearchStatus.loading,
            emptyMessage: state.results.isEmpty
                ? strings.noMatchingResults
                : null,
            emptyIllustrationAsset: MarnIllustrationAssets.locationNotFound,
            child: Column(
              children: [
                for (final listing in state.results)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ListingCard(
                      listing: listing,
                      onTap: () =>
                          context.push(AppRouter.adDetailPath(listing.id)),
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
