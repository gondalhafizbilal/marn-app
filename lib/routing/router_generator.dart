import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/auth/data/repositories/auth_repository.dart';
import 'package:marn/features/auth/logic/login_cubit.dart';
import 'package:marn/features/auth/logic/otp_cubit.dart';
import 'package:marn/features/auth/logic/register_cubit.dart';
import 'package:marn/features/auth/presentation/screens/login_screen.dart';
import 'package:marn/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:marn/features/auth/presentation/screens/register_screen.dart';
import 'package:marn/features/booking/data/repositories/booking_repository.dart';
import 'package:marn/features/booking/logic/booking_cubit.dart';
import 'package:marn/features/booking/presentation/screens/booking_screen.dart';
import 'package:marn/features/browse/data/repositories/browse_repository.dart';
import 'package:marn/features/browse/logic/browse_cubit.dart';
import 'package:marn/features/browse/logic/filters_cubit.dart';
import 'package:marn/features/browse/logic/search_cubit.dart';
import 'package:marn/features/browse/presentation/screens/browse_screen.dart';
import 'package:marn/features/browse/presentation/screens/filters_screen.dart';
import 'package:marn/features/browse/presentation/screens/search_results_screen.dart';
import 'package:marn/features/browse/presentation/screens/search_screen.dart';
import 'package:marn/features/chatbot/data/repositories/chatbot_repository.dart';
import 'package:marn/features/chatbot/logic/chatbot_cubit.dart';
import 'package:marn/features/chatbot/presentation/screens/chatbot_screen.dart';
import 'package:marn/features/chatbot/presentation/widgets/marn_chatbot_sheet.dart';
import 'package:marn/features/foundation/data/repositories/foundation_repository.dart';
import 'package:marn/features/foundation/logic/onboarding_cubit.dart';
import 'package:marn/features/foundation/presentation/screens/language_selection_screen.dart';
import 'package:marn/features/foundation/presentation/screens/onboarding_screen.dart';
import 'package:marn/features/foundation/presentation/screens/splash_screen.dart';
import 'package:marn/features/home/data/repositories/home_repository.dart';
import 'package:marn/features/home/logic/home_cubit.dart';
import 'package:marn/features/home/logic/home_detail_cubit.dart';
import 'package:marn/features/home/presentation/screens/ad_detail_screen.dart';
import 'package:marn/features/home/presentation/screens/agency_detail_screen.dart';
import 'package:marn/features/home/presentation/screens/home_screen.dart';
import 'package:marn/features/home/presentation/screens/individual_detail_screen.dart';
import 'package:marn/features/home/presentation/screens/notifications_screen.dart';
import 'package:marn/features/location/data/repositories/location_repository.dart';
import 'package:marn/features/location/logic/location_cubit.dart';
import 'package:marn/features/location/presentation/screens/location_intro_screen.dart';
import 'package:marn/features/location/presentation/screens/location_map_screen.dart';
import 'package:marn/features/payment/data/repositories/payment_repository.dart';
import 'package:marn/features/payment/logic/payment_cubit.dart';
import 'package:marn/features/payment/presentation/screens/payment_checkout_screen.dart';
import 'package:marn/features/post_ad/data/repositories/post_ad_repository.dart';
import 'package:marn/features/post_ad/logic/post_ad_cubit.dart';
import 'package:marn/features/post_ad/presentation/screens/post_ad_screen.dart';
import 'package:marn/features/profile/data/repositories/profile_repository.dart';
import 'package:marn/features/profile/logic/profile_cubit.dart';
import 'package:marn/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:marn/features/profile/presentation/screens/my_ads_screen.dart';
import 'package:marn/features/profile/presentation/screens/payment_history_screen.dart';
import 'package:marn/features/profile/presentation/screens/profile_screen.dart';
import 'package:marn/features/profile/presentation/screens/settings_screen.dart';
import 'package:marn/features/requests/data/repositories/requests_repository.dart';
import 'package:marn/features/requests/logic/request_form_cubit.dart';
import 'package:marn/features/requests/logic/requests_cubit.dart';
import 'package:marn/features/requests/presentation/screens/request_preview_screen.dart';
import 'package:marn/features/requests/presentation/screens/request_submit_screen.dart';
import 'package:marn/features/requests/presentation/screens/request_success_screen.dart';
import 'package:marn/features/requests/presentation/screens/requests_screen.dart';
import 'package:marn/features/reviews/data/repositories/reviews_repository.dart';
import 'package:marn/features/reviews/logic/review_form_cubit.dart';
import 'package:marn/features/reviews/logic/reviews_cubit.dart';
import 'package:marn/features/reviews/presentation/screens/review_list_screen.dart';
import 'package:marn/features/reviews/presentation/screens/write_review_screen.dart';
import 'package:marn/features/shell/presentation/widgets/marn_shell_scaffold.dart';
import 'package:marn/features/wishlist/data/repositories/wishlist_repository.dart';
import 'package:marn/features/wishlist/logic/wishlist_cubit.dart';
import 'package:marn/features/wishlist/presentation/screens/wishlist_detail_screen.dart';
import 'package:marn/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:marn/routing/app_router.dart';

class RouterGenerator {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouter.splash,
    routes: [
      GoRoute(
        path: AppRouter.splash,
        builder: (context, state) {
          final repository = sl<FoundationRepository>();
          return SplashScreen(
            assetPath: repository.splashAsset,
            onFinished: () =>
                context.go(repository.getInitialRouteAfterSplash()),
          );
        },
      ),
      GoRoute(
        path: AppRouter.language,
        builder: (context, state) {
          final repository = sl<FoundationRepository>();
          return LanguageSelectionScreen(
            backgroundAsset: repository.languageSelectionAsset,
            onSelected: () => context.go(AppRouter.login),
          );
        },
      ),
      GoRoute(
        path: AppRouter.onboarding,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                OnboardingCubit(repository: sl<FoundationRepository>())
                  ..load(context.strings),
            child: OnboardingScreen(
              onFinished: () {
                final repository = sl<FoundationRepository>();
                repository.completeOnboarding();
                context.go(
                  repository.isLanguageSelected
                      ? AppRouter.home
                      : AppRouter.language,
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LoginCubit(repository: sl<AuthRepository>()),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.register,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => RegisterCubit(repository: sl<AuthRepository>()),
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.verify,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => OtpCubit(repository: sl<AuthRepository>()),
            child: const OtpVerifyScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.location,
        builder: (context, state) => const LocationIntroScreen(),
      ),
      GoRoute(
        path: AppRouter.locationCurrent,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LocationCubit(repository: sl<LocationRepository>()),
            child: const LocationMapScreen(useCurrentLocation: true),
          );
        },
      ),
      GoRoute(
        path: AppRouter.locationManual,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LocationCubit(repository: sl<LocationRepository>()),
            child: const LocationMapScreen(useCurrentLocation: false),
          );
        },
      ),
      GoRoute(
        path: AppRouter.notifications,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                HomeCubit(repository: sl<HomeRepository>())
                  ..loadNotifications(),
            child: const NotificationsScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.chatbot,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                ChatbotCubit(repository: sl<ChatbotRepository>())..load(),
            child: const ChatbotScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.booking,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                BookingCubit(repository: sl<BookingRepository>())..load(),
            child: const BookingScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.reviewWrite,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ReviewFormCubit(repository: sl<ReviewsRepository>()),
            child: const WriteReviewScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.individualDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'worker-1';
          return BlocProvider(
            create: (_) =>
                HomeDetailCubit(repository: sl<HomeRepository>())
                  ..loadListing(id),
            child: const IndividualDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.reviews,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'worker-1';
          return BlocProvider(
            create: (_) =>
                ReviewsCubit(repository: sl<ReviewsRepository>())..load(id),
            child: const ReviewListScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.agencyDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'agency-1';
          return BlocProvider(
            create: (_) =>
                HomeDetailCubit(repository: sl<HomeRepository>())
                  ..loadAgency(id),
            child: const AgencyDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.adDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'ad-1';
          return BlocProvider(
            create: (_) =>
                HomeDetailCubit(repository: sl<HomeRepository>())
                  ..loadListing(id),
            child: const AdDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: '${AppRouter.wishlist}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'wish-1';
          return BlocProvider(
            create: (_) =>
                WishlistCubit(repository: sl<WishlistRepository>())
                  ..loadItem(id),
            child: const WishlistDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.requestPreview,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                RequestsCubit(repository: sl<RequestsRepository>())
                  ..loadPreview(),
            child: const RequestPreviewScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.requestSubmit,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                RequestFormCubit(repository: sl<RequestsRepository>()),
            child: const RequestSubmitScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.requestSuccess,
        builder: (context, state) => const RequestSuccessScreen(),
      ),
      GoRoute(
        path: AppRouter.editProfile,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                ProfileCubit(repository: sl<ProfileRepository>())
                  ..loadProfile(),
            child: const EditProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.ads,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                ProfileCubit(repository: sl<ProfileRepository>())..loadAds(),
            child: const MyAdsScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.adNew,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => PostAdCubit(repository: sl<PostAdRepository>()),
            child: const PostAdScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.paymentHistory,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                ProfileCubit(repository: sl<ProfileRepository>())
                  ..loadPayments(),
            child: const PaymentHistoryScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.payment,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                PaymentCubit(repository: sl<PaymentRepository>())..load(),
            child: const PaymentCheckoutScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRouter.profileSettings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRouter.browse,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                BrowseCubit(repository: sl<BrowseRepository>())..load(),
            child: const BrowseScreen(),
          );
        },
        routes: [
          GoRoute(
            path: 'search',
            builder: (context, state) {
              return BlocProvider(
                create: (_) => SearchCubit(repository: sl<BrowseRepository>()),
                child: const SearchScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'results',
                builder: (context, state) {
                  final query = state.uri.queryParameters['q'] ?? '';
                  return BlocProvider(
                    create: (_) =>
                        SearchCubit(repository: sl<BrowseRepository>())
                          ..submit(query),
                    child: const SearchResultsScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'filters',
            builder: (context, state) {
              return BlocProvider(
                create: (_) =>
                    FiltersCubit(repository: sl<BrowseRepository>())..load(),
                child: const FiltersScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.shell,
        redirect: (context, state) => AppRouter.home,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MarnShellScaffold(
            index: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            onAssistantTap: () => showMarnChatbotSheet(context),
            child: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.home,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        HomeCubit(repository: sl<HomeRepository>())
                          ..loadDashboard(),
                    child: const HomeScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.wishlist,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        WishlistCubit(repository: sl<WishlistRepository>())
                          ..load(),
                    child: const WishlistScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.requests,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        RequestsCubit(repository: sl<RequestsRepository>())
                          ..load(),
                    child: const RequestsScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.postAd,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        PostAdCubit(repository: sl<PostAdRepository>()),
                    child: const PostAdScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouter.profile,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        ProfileCubit(repository: sl<ProfileRepository>())
                          ..loadProfile(),
                    child: const ProfileScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
