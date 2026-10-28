import 'package:marn/features/payment/data/models/payment_models.dart';

class PaymentRepository {
  Future<PaymentSummary> getCheckout() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return const PaymentSummary(
      amount: 'QAR 700',
      fee: 'QAR 12',
      total: 'QAR 712',
      methods: [
        PaymentMethod(
          id: 'card-1',
          title: 'Visa ending 4242',
          subtitle: 'Default card',
          isDefault: true,
        ),
        PaymentMethod(
          id: 'apple-pay',
          title: 'Apple Pay',
          subtitle: 'Pay securely with wallet',
          isDefault: false,
        ),
      ],
    );
  }
}
