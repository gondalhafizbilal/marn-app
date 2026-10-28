import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/home/data/repositories/home_repository.dart';

enum DetailStatus { loading, loaded }

class HomeDetailState extends Equatable {
  const HomeDetailState({
    this.status = DetailStatus.loading,
    this.listing,
    this.agency,
  });

  final DetailStatus status;
  final MarketplaceListing? listing;
  final AgencySummary? agency;

  HomeDetailState copyWith({
    DetailStatus? status,
    MarketplaceListing? listing,
    AgencySummary? agency,
  }) {
    return HomeDetailState(
      status: status ?? this.status,
      listing: listing ?? this.listing,
      agency: agency ?? this.agency,
    );
  }

  @override
  List<Object?> get props => [status, listing, agency];
}

class HomeDetailCubit extends Cubit<HomeDetailState> {
  HomeDetailCubit({required this.repository}) : super(const HomeDetailState());

  final HomeRepository repository;

  Future<void> loadListing(String id) async {
    final listing = await repository.getListing(id);
    emit(state.copyWith(status: DetailStatus.loaded, listing: listing));
  }

  Future<void> loadAgency(String id) async {
    final agency = await repository.getAgency(id);
    emit(state.copyWith(status: DetailStatus.loaded, agency: agency));
  }
}
