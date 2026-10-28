import 'package:flutter_test/flutter_test.dart';
import 'package:marn/features/wishlist/data/models/wishlist_item.dart';

void main() {
  test('wishlist item falls back to profile when type is missing', () {
    const item = WishlistItem(
      id: 'legacy-item',
      title: 'Legacy saved item',
      category: 'Agency',
      note: 'Saved before item types were populated.',
      priceLabel: 'QAR 120/day',
      type: null,
    );

    expect(item.effectiveType, WishlistItemType.profile);
    expect(item.isProfile, isTrue);
    expect(item.primaryMeta, 'Agency | QAR 120/day');
  });
}
