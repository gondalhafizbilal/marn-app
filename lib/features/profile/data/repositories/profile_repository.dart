import 'package:marn/features/profile/data/models/profile_models.dart';

class ProfileRepository {
  Future<ProfileSummary> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return const ProfileSummary(
      name: 'Abdulrahman',
      phone: '+97454512345',
      email: 'abdulrahman@gmail.com',
      adsCount: 4,
      requestsCount: 12,
      rating: 4.8,
      avatarAsset: 'assets/images/profile/profile_avatar.png',
    );
  }

  Future<List<UserAd>> getAds() async {
    await Future<void>.delayed(const Duration(milliseconds: 160));
    return const [
      UserAd(
        id: 'ad-1',
        title: 'Laundry pickup package',
        status: 'Active',
        views: 82,
      ),
      UserAd(
        id: 'ad-2',
        title: 'Event crew weekend',
        status: 'Pending',
        views: 18,
      ),
    ];
  }

  Future<List<PaymentRecord>> getPaymentHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 160));
    return const [
      PaymentRecord(
        id: 'pay-1',
        title: 'Weekly cleaning booking',
        amount: 'QAR 700',
        date: 'July 7, 2026',
      ),
      PaymentRecord(
        id: 'pay-2',
        title: 'Featured ad package',
        amount: 'QAR 120',
        date: 'July 2, 2026',
      ),
    ];
  }
}
