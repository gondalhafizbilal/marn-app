import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/home/data/repositories/home_repository.dart';

enum HomeStatus { initial, loading, loaded }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboard,
    this.notifications = const [],
  });

  final HomeStatus status;
  final HomeDashboard? dashboard;
  final List<MarnNotification> notifications;

  HomeState copyWith({
    HomeStatus? status,
    HomeDashboard? dashboard,
    List<MarnNotification>? notifications,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, notifications];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.repository}) : super(const HomeState());

  final HomeRepository repository;

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final dashboard = await repository.getDashboard();
    emit(state.copyWith(status: HomeStatus.loaded, dashboard: dashboard));
  }

  Future<void> refreshDashboard() async {
    final dashboard = await repository.getDashboard();
    emit(state.copyWith(status: HomeStatus.loaded, dashboard: dashboard));
  }

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final notifications = await repository.getNotifications();
    emit(
      state.copyWith(status: HomeStatus.loaded, notifications: notifications),
    );
  }
}
