import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/payment/data/models/payment_models.dart';
import 'package:marn/features/payment/data/repositories/payment_repository.dart';

enum PaymentStatus { loading, ready, paid }

class PaymentState extends Equatable {
  const PaymentState({
    this.status = PaymentStatus.loading,
    this.summary,
    this.selectedMethodId,
  });

  final PaymentStatus status;
  final PaymentSummary? summary;
  final String? selectedMethodId;

  PaymentState copyWith({
    PaymentStatus? status,
    PaymentSummary? summary,
    String? selectedMethodId,
  }) {
    return PaymentState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      selectedMethodId: selectedMethodId ?? this.selectedMethodId,
    );
  }

  @override
  List<Object?> get props => [status, summary, selectedMethodId];
}

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.repository}) : super(const PaymentState());

  final PaymentRepository repository;

  Future<void> load() async {
    final summary = await repository.getCheckout();
    emit(
      state.copyWith(
        status: PaymentStatus.ready,
        summary: summary,
        selectedMethodId: summary.methods.first.id,
      ),
    );
  }

  void selectMethod(String id) {
    emit(state.copyWith(selectedMethodId: id));
  }

  void pay() {
    emit(state.copyWith(status: PaymentStatus.paid));
  }
}
