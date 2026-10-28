class AppRouter {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const language = '/language';
  static const login = '/login';
  static const register = '/register';
  static const verify = '/verify';
  static const location = '/setup/location';
  static const locationCurrent = '/setup/location/current';
  static const locationManual = '/setup/location/manual';
  static const shell = '/app';
  static const home = '/app/home';
  static const browse = '/app/browse';
  static const wishlist = '/app/wishlist';
  static const requests = '/app/requests';
  static const postAd = '/app/post-ad';
  static const profile = '/app/profile';
  static const search = '/app/browse/search';
  static const searchResults = '/app/browse/search/results';
  static const filters = '/app/browse/filters';
  static const chatbot = '/chatbot';
  static const individualDetail = '/app/home/individual/:id';
  static const agencyDetail = '/app/home/agency/:id';
  static const adDetail = '/app/home/ad/:id';
  static const reviews = '/app/home/individual/:id/reviews';
  static const requestPreview = '/app/requests/preview';
  static const requestSubmit = '/app/requests/submit';
  static const requestSuccess = '/app/requests/success';
  static const booking = '/app/booking';
  static const reviewWrite = '/app/review';
  static const notifications = '/app/notifications';
  static const editProfile = '/app/profile/edit';
  static const paymentHistory = '/app/profile/payments';
  static const profileSettings = '/app/profile/settings';
  static const adNew = '/app/profile/ads/new';
  static const ads = '/app/profile/ads';
  static const payment = '/app/profile/payments/checkout';

  static String individualDetailPath(String id) => '/app/home/individual/$id';

  static String agencyDetailPath(String id) => '/app/home/agency/$id';

  static String adDetailPath(String id) => '/app/home/ad/$id';

  static String reviewListPath(String id) => '/app/home/individual/$id/reviews';

  static String wishlistItemPath(String id) => '/app/wishlist/$id';
}
