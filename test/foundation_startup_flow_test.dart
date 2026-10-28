import 'package:flutter_test/flutter_test.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/features/foundation/data/repositories/foundation_repository.dart';
import 'package:marn/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<FoundationRepository> repositoryWith(
    Map<String, Object> cacheValues,
  ) async {
    SharedPreferences.setMockInitialValues(cacheValues);
    final cache = CacheHelper();
    await cache.init();
    return FoundationRepository(cache: cache);
  }

  test('splash routes first-time users to onboarding', () async {
    final repository = await repositoryWith({});

    expect(repository.getInitialRouteAfterSplash(), AppRouter.onboarding);
  });

  test('splash routes onboarded users without language to language', () async {
    final repository = await repositoryWith({
      'foundation.onboardingCompleted': 'true',
    });

    expect(repository.getInitialRouteAfterSplash(), AppRouter.language);
  });

  test('splash routes completed users to home', () async {
    final repository = await repositoryWith({
      'foundation.onboardingCompleted': 'true',
      'languageCode': 'en',
    });

    expect(repository.getInitialRouteAfterSplash(), AppRouter.home);
  });

  test('completeOnboarding persists the onboarding flag', () async {
    final repository = await repositoryWith({});

    await repository.completeOnboarding();

    expect(repository.isOnboardingCompleted, isTrue);
  });
}
