class BookingQuote {
  const BookingQuote({
    required this.provider,
    required this.service,
    required this.dateRange,
    required this.total,
  });

  final String provider;
  final String service;
  final String dateRange;
  final String total;
}
