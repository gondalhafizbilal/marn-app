import 'package:marn/features/home/data/models/home_models.dart';

class BrowseCategory {
  const BrowseCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconName;
}

class BrowseDashboard {
  const BrowseDashboard({
    required this.categories,
    required this.recommendedListings,
  });

  final List<BrowseCategory> categories;
  final List<MarketplaceListing> recommendedListings;
}

class FilterOption {
  const FilterOption({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  final String id;
  final String label;
  final bool isSelected;

  FilterOption toggled() {
    return FilterOption(id: id, label: label, isSelected: !isSelected);
  }
}
