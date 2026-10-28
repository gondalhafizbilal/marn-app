import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/auth/data/models/auth_models.dart';
import 'package:marn/features/auth/data/repositories/auth_repository.dart';
import 'package:marn/features/auth/logic/auth_status.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.fullName = '',
    this.countryCode = '+974',
    this.phoneNumber = '',
    this.email = '',
    this.status = AuthStatus.idle,
    this.errorMessage,
  });

  final String fullName;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final AuthStatus status;
  final String? errorMessage;

  RegisterState copyWith({
    String? fullName,
    String? countryCode,
    String? phoneNumber,
    String? email,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    countryCode,
    phoneNumber,
    email,
    status,
    errorMessage,
  ];
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository})
    : super(
        const RegisterState(
          phoneNumber: '1234 4567',
          email: 'brooklynsimmons@gmail.com',
        ),
      );

  final AuthRepository repository;

  void fullNameChanged(String value) => emit(state.copyWith(fullName: value));

  void countryCodeChanged(String value) {
    emit(state.copyWith(countryCode: value, status: AuthStatus.idle));
  }

  void phoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void emailChanged(String value) => emit(state.copyWith(email: value));

  Future<void> submit() async {
    if (state.fullName.trim().isEmpty || state.phoneNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Name and phone number are required.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.submitting));
    await repository.register(
      RegisterAccountDraft(
        fullName: state.fullName,
        phoneNumber: '${state.countryCode} ${state.phoneNumber}',
        email: state.email,
      ),
    );
    emit(state.copyWith(status: AuthStatus.success));
  }
}
