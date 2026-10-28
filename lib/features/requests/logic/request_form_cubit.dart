import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/requests/data/models/request_models.dart';
import 'package:marn/features/requests/data/repositories/requests_repository.dart';

enum RequestFormStatus { editing, submitting, submitted }

class RequestFormState extends Equatable {
  const RequestFormState({
    this.category = 'Housemaids',
    this.description = '',
    this.location = 'Doha',
    this.status = RequestFormStatus.editing,
    this.submittedRequest,
  });

  final String category;
  final String description;
  final String location;
  final RequestFormStatus status;
  final MarnRequest? submittedRequest;

  RequestFormState copyWith({
    String? category,
    String? description,
    String? location,
    RequestFormStatus? status,
    MarnRequest? submittedRequest,
  }) {
    return RequestFormState(
      category: category ?? this.category,
      description: description ?? this.description,
      location: location ?? this.location,
      status: status ?? this.status,
      submittedRequest: submittedRequest ?? this.submittedRequest,
    );
  }

  @override
  List<Object?> get props => [
    category,
    description,
    location,
    status,
    submittedRequest,
  ];
}

class RequestFormCubit extends Cubit<RequestFormState> {
  RequestFormCubit({required this.repository})
    : super(const RequestFormState());

  final RequestsRepository repository;

  void categoryChanged(String value) => emit(state.copyWith(category: value));

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void locationChanged(String value) => emit(state.copyWith(location: value));

  Future<void> submit() async {
    emit(state.copyWith(status: RequestFormStatus.submitting));
    final request = await repository.submitRequest(
      RequestDraft(
        category: state.category,
        description: state.description,
        location: state.location,
      ),
    );
    emit(
      state.copyWith(
        status: RequestFormStatus.submitted,
        submittedRequest: request,
      ),
    );
  }
}
