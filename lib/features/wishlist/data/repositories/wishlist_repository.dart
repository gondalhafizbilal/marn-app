import 'dart:async';

import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/wishlist/data/models/wishlist_item.dart';

class WishlistRepository {
  final _items = <WishlistItem>[..._seedItems];
  final _controller = StreamController<List<WishlistItem>>.broadcast();

  Stream<List<WishlistItem>> watchWishlist() async* {
    yield List.unmodifiable(_items);
    yield* _controller.stream;
  }

  Future<List<WishlistItem>> getWishlist() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return List.unmodifiable(_items);
  }

  Future<WishlistItem> getWishlistItem(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 140));
    return _items.firstWhere(
      (item) => item.id == id,
      orElse: () => _items.first,
    );
  }

  Future<WishlistItem> saveProfile(MarketplaceListing listing) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));

    final existingIndex = _items.indexWhere(
      (item) =>
          item.sourceId == listing.id || item.id == _profileId(listing.id),
    );
    if (existingIndex != -1) {
      return _items[existingIndex];
    }

    final item = WishlistItem(
      id: _profileId(listing.id),
      type: WishlistItemType.profile,
      title: listing.title,
      category: listing.category,
      note: listing.description,
      priceLabel: listing.priceLabel,
      ageLabel: listing.ageLabel,
      nationality: listing.nationality,
      location: _locationLabel(listing.location),
      imageUrl: listing.imageUrl,
      sourceId: listing.id,
    );
    _items.insert(0, item);
    _notify();

    return item;
  }

  bool isProfileSaved(String sourceId) {
    return _items.any(
      (item) => item.sourceId == sourceId || item.id == _profileId(sourceId),
    );
  }

  void _notify() {
    _controller.add(List.unmodifiable(_items));
  }

  static String _profileId(String id) => 'profile-$id';

  static String _locationLabel(String location) {
    if (location.toLowerCase().contains('qatar')) {
      return location;
    }

    return '$location, Qatar';
  }

  static const _seedItems = [
    WishlistItem(
      id: 'profile-seed-worker-1',
      type: WishlistItemType.profile,
      title: 'Senior housemaid',
      category: 'Housemaids',
      note:
          'Verified profile with cleaning, cooking, and childcare experience.',
      priceLabel: 'QAR 120/day',
      ageLabel: 'Age 26',
      nationality: 'Philippines',
      location: 'Doha, Qatar',
      sourceId: 'seed-worker-1',
    ),
    WishlistItem(
      id: 'profile-worker-2',
      type: WishlistItemType.profile,
      title: 'Live-in home assistant',
      category: 'Housemaids',
      note: 'Available for family home care and everyday cleaning support.',
      priceLabel: 'QAR 150/day',
      ageLabel: 'Age 29',
      nationality: 'Indonesia',
      location: 'Al Sadd, Qatar',
      sourceId: 'worker-2',
    ),
    WishlistItem(
      id: 'profile-worker-3',
      type: WishlistItemType.profile,
      title: 'Childcare specialist',
      category: 'Housemaids Local',
      note: 'Experienced with childcare, school routines, and light cooking.',
      priceLabel: 'QAR 180/day',
      ageLabel: 'Age 31',
      nationality: 'Kenya',
      location: 'West Bay, Qatar',
      sourceId: 'worker-3',
    ),
    WishlistItem(
      id: 'profile-worker-4',
      type: WishlistItemType.profile,
      title: 'Part-time cleaner',
      category: 'Services',
      note: 'Saved for weekly apartment cleaning and laundry help.',
      priceLabel: 'QAR 90/day',
      ageLabel: 'Age 24',
      nationality: 'Nepal',
      location: 'Lusail, Qatar',
      sourceId: 'worker-4',
    ),
  ];
}
