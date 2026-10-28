import 'package:marn/features/browse/data/models/browse_models.dart';
import 'package:marn/features/home/data/models/home_models.dart';

class BrowseRepository {
  Future<BrowseDashboard> getDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return const BrowseDashboard(
      categories: [
        BrowseCategory(
          id: 'housemaids',
          title: 'Housemaids',
          subtitle: 'Local and agency workers',
          iconName: 'person',
        ),
        BrowseCategory(
          id: 'travel',
          title: 'Travel',
          subtitle: 'Tours, tickets, and transport',
          iconName: 'flight',
        ),
        BrowseCategory(
          id: 'events',
          title: 'Events',
          subtitle: 'Staffing and event services',
          iconName: 'event',
        ),
        BrowseCategory(
          id: 'services',
          title: 'Services',
          subtitle: 'Laundry, car, and home services',
          iconName: 'service',
        ),
      ],
      recommendedListings: _results,
    );
  }

  Future<List<MarketplaceListing>> search(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (query.trim().isEmpty) {
      return _results;
    }
    final lower = query.toLowerCase();
    return _results
        .where(
          (item) =>
              item.title.toLowerCase().contains(lower) ||
              item.category.toLowerCase().contains(lower),
        )
        .toList();
  }

  List<FilterOption> getFilters() {
    return const [
      FilterOption(id: 'nearby', label: 'Nearby', isSelected: true),
      FilterOption(id: 'verified', label: 'Verified', isSelected: true),
      FilterOption(
        id: 'available',
        label: 'Available today',
        isSelected: false,
      ),
      FilterOption(id: 'top-rated', label: 'Top rated', isSelected: false),
      FilterOption(id: 'with-offers', label: 'With offers', isSelected: false),
    ];
  }

  static const _results = [
    MarketplaceListing(
      id: 'worker-1',
      title: 'Experienced housemaid',
      category: 'Housemaids',
      location: 'West Bay',
      priceLabel: 'QAR 120/day',
      rating: 4.8,
      isFeatured: true,
      description: 'Verified housemaid available for weekly bookings.',
    ),
    MarketplaceListing(
      id: 'service-1',
      title: 'Event support crew',
      category: 'Events',
      location: 'The Pearl',
      priceLabel: 'From QAR 900',
      rating: 4.9,
      description: 'Hosts and coordinators for private events.',
    ),
    MarketplaceListing(
      id: 'ad-1',
      title: 'Laundry pickup package',
      category: 'Laundry',
      location: 'Al Sadd',
      priceLabel: 'QAR 45/order',
      rating: 4.6,
      description: 'Same-day pickup and delivery.',
    ),
  ];
}
