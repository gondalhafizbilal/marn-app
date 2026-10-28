class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isDefault,
  });

  final String id;
  final String title;
  final String subtitle;
  final bool isDefault;
}

class PaymentSummary {
  const PaymentSummary({
    required this.amount,
    required this.fee,
    required this.total,
    required this.methods,
  });

  final String amount;
  final String fee;
  final String total;
  final List<PaymentMethod> methods;
}
