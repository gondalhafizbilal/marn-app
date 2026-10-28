import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/auth/data/repositories/auth_repository.dart';
import 'package:marn/features/auth/logic/auth_status.dart';

class OtpState extends Equatable {
  const OtpState({
    this.code = '',
    this.status = AuthStatus.idle,
    this.errorMessage,
  });

  final String code;
  final AuthStatus status;
  final String? errorMessage;

  OtpState copyWith({String? code, AuthStatus? status, String? errorMessage}) {
    return OtpState(
      code: code ?? this.code,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, status, errorMessage];
}

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.repository}) : super(const OtpState(code: '54'));

  final AuthRepository repository;

  void codeChanged(String value) {
    emit(state.copyWith(code: value, status: AuthStatus.idle));
  }

  Future<void> verify() async {
    emit(state.copyWith(status: AuthStatus.submitting));
    final verified = await repository.verifyOtp(state.code);
    emit(
      state.copyWith(
        status: verified ? AuthStatus.success : AuthStatus.failure,
        errorMessage: verified ? null : 'Enter the 4 digit code.',
      ),
    );
  }
}
