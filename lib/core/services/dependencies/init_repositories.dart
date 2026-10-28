import 'package:marn/features/auth/data/repositories/auth_repository.dart';
import 'package:marn/features/booking/data/repositories/booking_repository.dart';
import 'package:marn/features/browse/data/repositories/browse_repository.dart';
import 'package:marn/features/chatbot/data/repositories/chatbot_repository.dart';
import 'package:marn/features/foundation/data/repositories/foundation_repository.dart';
import 'package:marn/features/home/data/repositories/home_repository.dart';
import 'package:marn/features/location/data/repositories/location_repository.dart';
import 'package:marn/features/payment/data/repositories/payment_repository.dart';
import 'package:marn/features/post_ad/data/repositories/post_ad_repository.dart';
import 'package:marn/features/profile/data/repositories/profile_repository.dart';
import 'package:marn/features/requests/data/repositories/requests_repository.dart';
import 'package:marn/features/reviews/data/repositories/reviews_repository.dart';
import 'package:marn/features/wishlist/data/repositories/wishlist_repository.dart';
import 'package:marn/core/services/service_locator.dart';

Future<void> initRepositories() async {
  sl.registerLazySingleton<FoundationRepository>(
    () => FoundationRepository(cache: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(AuthRepository.new);
  sl.registerLazySingleton<LocationRepository>(LocationRepository.new);
  sl.registerLazySingleton<HomeRepository>(HomeRepository.new);
  sl.registerLazySingleton<BrowseRepository>(BrowseRepository.new);
  sl.registerLazySingleton<WishlistRepository>(WishlistRepository.new);
  sl.registerLazySingleton<RequestsRepository>(RequestsRepository.new);
  sl.registerLazySingleton<ProfileRepository>(ProfileRepository.new);
  sl.registerLazySingleton<ChatbotRepository>(ChatbotRepository.new);
  sl.registerLazySingleton<BookingRepository>(BookingRepository.new);
  sl.registerLazySingleton<PaymentRepository>(PaymentRepository.new);
  sl.registerLazySingleton<ReviewsRepository>(ReviewsRepository.new);
  sl.registerLazySingleton<PostAdRepository>(PostAdRepository.new);
}
