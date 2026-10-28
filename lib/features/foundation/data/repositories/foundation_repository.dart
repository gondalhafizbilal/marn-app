import 'package:marn/features/foundation/data/models/onboarding_slide.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/routing/app_router.dart';

class FoundationRepository {
  FoundationRepository({required this.cache});

  static const _onboardingCompletedKey = 'foundation.onboardingCompleted';
  static const _completedValue = 'true';
  static const _languageCodeKey = 'languageCode';

  final CacheHelper cache;

  String get splashAsset => 'assets/brand/splash_screen.png';

  String get languageSelectionAsset =>
      'assets/brand/splash_language_selection.png';

  String getInitialRouteAfterSplash() {
    if (!isOnboardingCompleted) {
      return AppRouter.onboarding;
    }

    if (!isLanguageSelected) {
      return AppRouter.language;
    }

    return AppRouter.home;
  }

  bool get isOnboardingCompleted {
    return cache.getDataString(key: _onboardingCompletedKey) == _completedValue;
  }

  bool get isLanguageSelected {
    final languageCode = cache.getDataString(key: _languageCodeKey);
    return languageCode != null && languageCode.trim().isNotEmpty;
  }

  Future<void> completeOnboarding() async {
    await cache.saveData(key: _onboardingCompletedKey, value: _completedValue);
  }

  List<OnboardingSlide> getOnboardingSlides(AppStrings strings) {
    return [
      OnboardingSlide(
        title: strings.onboardingPostDiscover,
        subtitle: strings.onboardingPostDiscoverSubtitle,
        imageAsset: 'assets/brand/onboarding_ads_1.png',
      ),
      OnboardingSlide(
        title: strings.onboardingCompare,
        subtitle: strings.onboardingCompareSubtitle,
        imageAsset: 'assets/brand/onboarding_ads_2.png',
      ),
      OnboardingSlide(
        title: strings.onboardingBook,
        subtitle: strings.onboardingBookSubtitle,
        imageAsset: 'assets/brand/onboarding_ads_3.png',
      ),
    ];
  }
}
