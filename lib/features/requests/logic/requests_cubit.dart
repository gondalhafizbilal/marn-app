import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/requests/data/models/request_models.dart';
import 'package:marn/features/requests/data/repositories/requests_repository.dart';

enum RequestsStatus { loading, loaded }

class RequestsState extends Equatable {
  const RequestsState({
    this.status = RequestsStatus.loading,
    this.requests = const [],
    this.preview,
  });

  final RequestsStatus status;
  final List<MarnRequest> requests;
  final MarnRequest? preview;

  RequestsState copyWith({
    RequestsStatus? status,
    List<MarnRequest>? requests,
    MarnRequest? preview,
  }) {
    return RequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      preview: preview ?? this.preview,
    );
  }

  @override
  List<Object?> get props => [status, requests, preview];
}

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({required this.repository}) : super(const RequestsState());

  final RequestsRepository repository;

  Future<void> load() async {
    final requests = await repository.getRequests();
    emit(state.copyWith(status: RequestsStatus.loaded, requests: requests));
  }

  Future<void> loadPreview() async {
    final request = await repository.getRequestPreview();
    emit(state.copyWith(status: RequestsStatus.loaded, preview: request));
  }
}
