import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/browse/data/models/browse_models.dart';
import 'package:marn/features/browse/data/repositories/browse_repository.dart';

enum BrowseStatus { initial, loading, loaded }

class BrowseState extends Equatable {
  const BrowseState({this.status = BrowseStatus.initial, this.dashboard});

  final BrowseStatus status;
  final BrowseDashboard? dashboard;

  BrowseState copyWith({BrowseStatus? status, BrowseDashboard? dashboard}) {
    return BrowseState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
    );
  }

  @override
  List<Object?> get props => [status, dashboard];
}

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit({required this.repository}) : super(const BrowseState());

  final BrowseRepository repository;

  Future<void> load() async {
    emit(state.copyWith(status: BrowseStatus.loading));
    final dashboard = await repository.getDashboard();
    emit(state.copyWith(status: BrowseStatus.loaded, dashboard: dashboard));
  }
}
