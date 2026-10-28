import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/location/data/models/marn_location.dart';
import 'package:marn/features/location/data/repositories/location_repository.dart';

enum LocationStatus { idle, loading, selected }

class LocationState extends Equatable {
  const LocationState({this.status = LocationStatus.idle, this.location});

  final LocationStatus status;
  final MarnLocation? location;

  LocationState copyWith({LocationStatus? status, MarnLocation? location}) {
    return LocationState(
      status: status ?? this.status,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [status, location];
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.repository}) : super(const LocationState());

  final LocationRepository repository;

  Future<void> useCurrentLocation() async {
    emit(state.copyWith(status: LocationStatus.loading));
    final location = await repository.useCurrentLocation();
    emit(state.copyWith(status: LocationStatus.selected, location: location));
  }

  Future<void> selectManualLocation() async {
    emit(state.copyWith(status: LocationStatus.loading));
    final location = await repository.selectManualLocation();
    emit(state.copyWith(status: LocationStatus.selected, location: location));
  }
}
