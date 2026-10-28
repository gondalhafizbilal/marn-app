import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/browse/data/repositories/browse_repository.dart';
import 'package:marn/features/home/data/models/home_models.dart';

enum SearchStatus { idle, loading, loaded }

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.status = SearchStatus.idle,
    this.results = const [],
  });

  final String query;
  final SearchStatus status;
  final List<MarketplaceListing> results;

  SearchState copyWith({
    String? query,
    SearchStatus? status,
    List<MarketplaceListing>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [query, status, results];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.repository}) : super(const SearchState());

  final BrowseRepository repository;

  void queryChanged(String value) {
    emit(state.copyWith(query: value));
  }

  Future<void> submit([String? query]) async {
    final effectiveQuery = query ?? state.query;
    emit(state.copyWith(query: effectiveQuery, status: SearchStatus.loading));
    final results = await repository.search(effectiveQuery);
    emit(state.copyWith(status: SearchStatus.loaded, results: results));
  }
}
