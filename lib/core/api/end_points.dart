import 'package:marn/core/config/app_config.dart';

class EndPoints {
  static String get baseUrl => AppConfig.instance.baseUrl;
  static String get chatbotBaseUrl => AppConfig.instance.chatbotBaseUrl;

  static String get graphql => '$baseUrl/graphql';

  static String get authLogin => '$baseUrl/v1/auth/login';
  static String get authRegister => '$baseUrl/v1/auth/register';
  static String get authVerify => '$baseUrl/v1/auth/verify';
  static String get authLogout => '$baseUrl/v1/auth/logout';
  static String get authMe => '$baseUrl/v1/auth/me';
  static String get authGuest => '$baseUrl/v1/auth/guest';

  static String get categories => '$baseUrl/v1/categories';
  static String get locations => '$baseUrl/v1/locations';
  static String get listings => '$baseUrl/v1/listings';
  static String get ads => '$baseUrl/v1/ads';
  static String get packages => '$baseUrl/v1/packages';
  static String get bookings => '$baseUrl/v1/bookings';
  static String get requests => '$baseUrl/v1/requests';
  static String get reviews => '$baseUrl/v1/reviews';
  static String get wishlist => '$baseUrl/v1/wishlist';
  static String get notifications => '$baseUrl/v1/notifications';
  static String get chatThreads => '$baseUrl/v1/chat/threads';
  static String get chatbotSessions => '$chatbotBaseUrl/v1/sessions';
}
