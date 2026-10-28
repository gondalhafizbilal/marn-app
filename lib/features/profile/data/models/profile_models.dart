class ProfileSummary {
  const ProfileSummary({
    required this.name,
    required this.phone,
    required this.email,
    required this.adsCount,
    required this.requestsCount,
    required this.rating,
    this.avatarAsset,
  });

  final String name;
  final String phone;
  final String email;
  final int adsCount;
  final int requestsCount;
  final double rating;
  final String? avatarAsset;
}

class UserAd {
  const UserAd({
    required this.id,
    required this.title,
    required this.status,
    required this.views,
  });

  final String id;
  final String title;
  final String status;
  final int views;
}

class PaymentRecord {
  const PaymentRecord({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  final String id;
  final String title;
  final String amount;
  final String date;
}
