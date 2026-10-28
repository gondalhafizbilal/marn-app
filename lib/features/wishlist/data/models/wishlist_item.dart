enum WishlistItemType { profile, agency, service, ad }

class WishlistItem {
  const WishlistItem({
    required this.id,
    required this.title,
    required this.category,
    required this.note,
    required this.priceLabel,
    this.type = WishlistItemType.profile,
    this.ageLabel,
    this.nationality,
    this.location,
    this.imageUrl,
    this.sourceId,
  });

  final String id;
  final String title;
  final String category;
  final String note;
  final String priceLabel;
  final WishlistItemType? type;
  final String? ageLabel;
  final String? nationality;
  final String? location;
  final String? imageUrl;
  final String? sourceId;

  WishlistItemType get effectiveType => type ?? WishlistItemType.profile;

  bool get isProfile => effectiveType == WishlistItemType.profile;

  String get primaryMeta {
    if (!isProfile) {
      return '$category | $priceLabel';
    }

    final parts = [
      if (ageLabel != null && ageLabel!.isNotEmpty) ageLabel!,
      if (nationality != null && nationality!.isNotEmpty) nationality!,
    ];

    return parts.isEmpty ? '$category | $priceLabel' : parts.join(' | ');
  }

  String get locationLabel {
    if (location != null && location!.isNotEmpty) {
      return location!;
    }

    return note;
  }
}
