import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/routing/app_router.dart';

class HomeRepository {
  Future<HomeDashboard> getDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return HomeDashboard(
      location: _location,
      promo: _promo,
      services: _services,
      featuredListings: _listings,
      agencies: _agencies,
      quickActions: const ['Housemaids', 'Laundry', 'Events', 'Car services'],
    );
  }

  Future<MarketplaceListing> getListing(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 160));
    return _listings.firstWhere(
      (listing) => listing.id == id,
      orElse: () => _listings.first,
    );
  }

  Future<AgencySummary> getAgency(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 160));
    return _agencies.firstWhere(
      (agency) => agency.id == id,
      orElse: () => _agencies.first,
    );
  }

  Future<List<MarnNotification>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      MarnNotification(
        id: 'notif-1',
        title: 'Request accepted',
        body: 'Doha Care Agency accepted your home cleaning request.',
        timeAgo: '2 min ago',
        isUnread: true,
      ),
      MarnNotification(
        id: 'notif-2',
        title: 'Payment receipt ready',
        body: 'Your receipt for booking M-1048 is available.',
        timeAgo: '1 hour ago',
        isUnread: true,
      ),
      MarnNotification(
        id: 'notif-3',
        title: 'New featured ad package',
        body: 'Boost your service ad for the weekend.',
        timeAgo: 'Yesterday',
        isUnread: false,
      ),
    ];
  }

  static const _location = HomeLocationSummary(
    label: 'Location',
    city: 'Doha',
    country: 'Qatar',
    address: 'Jl. Jend. Sudirman, Gowongan, Kec. Jetis, Kota Yogyakarta',
    latitude: 25.2854,
    longitude: 51.5310,
  );

  static const _promo = HomePromo(
    title: 'Connecting homes\nwith trusted workers',
    subtitle: '*Early bird discounts available',
    currentSlide: 1,
    totalSlides: 3,
  );

  static const _services = [
    HomeServiceCategory(
      id: 'housemaids',
      title: 'Housemaids',
      iconName: 'housemaid',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'housemaids-local',
      title: 'Housemaids Local',
      iconName: 'housemaid_local',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'hajj-umrah',
      title: 'Hajj & Umrah',
      iconName: 'travel',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'events',
      title: 'Event Services',
      iconName: 'event',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'advertisements',
      title: 'Advertisements',
      iconName: 'ads',
      routePath: AppRouter.postAd,
    ),
    HomeServiceCategory(
      id: 'services',
      title: 'Services',
      iconName: 'services',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'home-projects',
      title: 'Home Projects',
      iconName: 'home_projects',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'laundry',
      title: 'Laundry',
      iconName: 'laundry',
      routePath: AppRouter.browse,
    ),
    HomeServiceCategory(
      id: 'car-service',
      title: 'Car Service',
      iconName: 'car',
      routePath: AppRouter.browse,
    ),
  ];

  static const _listings = [
    MarketplaceListing(
      id: 'worker-1',
      title: 'Experienced housemaid',
      category: 'Housemaids',
      location: 'West Bay',
      priceLabel: 'QAR 120/day',
      rating: 4.8,
      isFeatured: true,
      description:
          'Verified profile with cleaning, cooking, and childcare experience.',
      ageLabel: 'Age 26',
      nationality: 'Philippines',
    ),
    MarketplaceListing(
      id: 'ad-1',
      title: 'Laundry pickup package',
      category: 'Laundry',
      location: 'Al Sadd',
      priceLabel: 'QAR 45/order',
      rating: 4.6,
      description: 'Same-day pickup and delivery with package tracking.',
    ),
    MarketplaceListing(
      id: 'service-1',
      title: 'Wedding event crew',
      category: 'Events',
      location: 'The Pearl',
      priceLabel: 'From QAR 900',
      rating: 4.9,
      isFeatured: true,
      description: 'Hosts, coordinators, and event staff for private bookings.',
    ),
  ];

  static const _agencies = [
    AgencySummary(
      id: 'agency-1',
      name: 'Doha Care Agency',
      specialty: 'Household staff',
      location: 'Doha',
      rating: 4.9,
      openRequests: 12,
    ),
    AgencySummary(
      id: 'agency-2',
      name: 'Marn Events Pro',
      specialty: 'Event staffing',
      location: 'Lusail',
      rating: 4.7,
      openRequests: 8,
    ),
  ];
}
