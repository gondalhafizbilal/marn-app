import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/auth/data/repositories/auth_repository.dart';
import 'package:marn/features/auth/logic/auth_status.dart';

class LoginState extends Equatable {
  const LoginState({
    this.countryCode = '+974',
    this.phoneNumber = '',
    this.status = AuthStatus.idle,
    this.errorMessage,
  });

  final String countryCode;
  final String phoneNumber;
  final AuthStatus status;
  final String? errorMessage;

  LoginState copyWith({
    String? countryCode,
    String? phoneNumber,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [countryCode, phoneNumber, status, errorMessage];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repository})
    : super(const LoginState(phoneNumber: '97416541321'));

  final AuthRepository repository;

  void countryCodeChanged(String value) {
    emit(state.copyWith(countryCode: value, status: AuthStatus.idle));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phoneNumber: value, status: AuthStatus.idle));
  }

  Future<void> submit() async {
    if (state.phoneNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Enter your phone number.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.submitting));
    await repository.submitPhone('${state.countryCode} ${state.phoneNumber}');
    emit(state.copyWith(status: AuthStatus.success));
  }
}
