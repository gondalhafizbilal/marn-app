import 'package:marn/features/booking/data/models/booking_models.dart';

class BookingRepository {
  Future<BookingQuote> getQuote() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return const BookingQuote(
      provider: 'Doha Care Agency',
      service: 'Weekly cleaning',
      dateRange: 'Jul 10 - Jul 17',
      total: 'QAR 700',
    );
  }
}
