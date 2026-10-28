class MarketplaceListing {
  const MarketplaceListing({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.priceLabel,
    required this.rating,
    required this.description,
    this.isFeatured = false,
    this.ageLabel,
    this.nationality,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final String location;
  final String priceLabel;
  final double rating;
  final String description;
  final bool isFeatured;
  final String? ageLabel;
  final String? nationality;
  final String? imageUrl;
}

class HomeLocationSummary {
  const HomeLocationSummary({
    required this.label,
    required this.city,
    required this.country,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String label;
  final String city;
  final String country;
  final String address;
  final double latitude;
  final double longitude;

  String get displayName => '$city, $country';
}

class HomePromo {
  const HomePromo({
    required this.title,
    required this.subtitle,
    required this.currentSlide,
    required this.totalSlides,
  });

  final String title;
  final String subtitle;
  final int currentSlide;
  final int totalSlides;
}

class HomeServiceCategory {
  const HomeServiceCategory({
    required this.id,
    required this.title,
    required this.iconName,
    required this.routePath,
  });

  final String id;
  final String title;
  final String iconName;
  final String routePath;
}

class AgencySummary {
  const AgencySummary({
    required this.id,
    required this.name,
    required this.specialty,
    required this.location,
    required this.rating,
    required this.openRequests,
  });

  final String id;
  final String name;
  final String specialty;
  final String location;
  final double rating;
  final int openRequests;
}

class HomeDashboard {
  const HomeDashboard({
    required this.location,
    required this.promo,
    required this.services,
    required this.featuredListings,
    required this.agencies,
    required this.quickActions,
  });

  final HomeLocationSummary location;
  final HomePromo promo;
  final List<HomeServiceCategory> services;
  final List<MarketplaceListing> featuredListings;
  final List<AgencySummary> agencies;
  final List<String> quickActions;
}

class MarnNotification {
  const MarnNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.isUnread,
  });

  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final bool isUnread;
}
