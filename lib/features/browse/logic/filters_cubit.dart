import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/browse/data/models/browse_models.dart';
import 'package:marn/features/browse/data/repositories/browse_repository.dart';

class FiltersState extends Equatable {
  const FiltersState({this.options = const []});

  final List<FilterOption> options;

  FiltersState copyWith({List<FilterOption>? options}) {
    return FiltersState(options: options ?? this.options);
  }

  @override
  List<Object?> get props => [options];
}

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit({required this.repository}) : super(const FiltersState());

  final BrowseRepository repository;

  void load() {
    emit(state.copyWith(options: repository.getFilters()));
  }

  void toggle(String id) {
    final updated = state.options
        .map((option) => option.id == id ? option.toggled() : option)
        .toList();
    emit(state.copyWith(options: updated));
  }
}
