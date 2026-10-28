import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/ui/marn_illustration_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/home/data/models/home_models.dart';
import 'package:marn/features/home/logic/home_cubit.dart';
import 'package:marn/features/location/data/repositories/location_repository.dart';
import 'package:marn/features/location/logic/location_cubit.dart';
import 'package:marn/features/location/presentation/screens/location_map_screen.dart';
import 'package:marn/routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _designWidth = 375.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final strings = context.strings;
        final dashboard = state.dashboard;

        return ColoredBox(
          color: AppColors.brandBeige,
          child: MarnStateView(
            isLoading: state.status == HomeStatus.loading,
            emptyMessage: dashboard == null ? strings.noHomeData : null,
            emptyIllustrationAsset: MarnIllustrationAssets.oops,
            child: dashboard == null
                ? const SizedBox.shrink()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth.isFinite
                          ? constraints.maxWidth
                          : _designWidth;
                      final scale = width / _designWidth;

                      return RefreshIndicator(
                        color: AppColors.brandMaroon,
                        onRefresh: () =>
                            context.read<HomeCubit>().refreshDashboard(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SafeArea(
                                bottom: false,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    24 * scale,
                                    14 * scale,
                                    24 * scale,
                                    0,
                                  ),
                                  child: Column(
                                    children: [
                                      _HomeHeader(
                                        location: dashboard.location,
                                        scale: scale,
                                      ),
                                      SizedBox(height: 20 * scale),
                                      _PromoCarousel(
                                        promo: dashboard.promo,
                                        scale: scale,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20 * scale),

                              Container(
                                width: _designWidth * scale,
                                height: 471 * scale,
                                color: const Color(
                                  0xFFFAFAF9,
                                ).withValues(alpha: .5),
                                padding: EdgeInsets.fromLTRB(
                                  24 * scale,
                                  26 * scale,
                                  24 * scale,
                                  28 * scale,
                                ),
                                child: _ServicesGrid(
                                  services: dashboard.services,
                                  scale: scale,
                                ),
                              ),
                              SizedBox(height: 104 * scale),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.location, required this.scale});

  final HomeLocationSummary location;
  final double scale;

  Future<void> _showLocationPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.baseBlack.withValues(alpha: .42),
      builder: (sheetContext) {
        return BlocProvider(
          create: (_) => LocationCubit(repository: sl<LocationRepository>()),
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availableHeight =
                    MediaQuery.sizeOf(sheetContext).height -
                    MediaQuery.paddingOf(sheetContext).top -
                    16;
                final modalHeight = availableHeight.clamp(360.0, 565.0);

                return SizedBox(
                  height: modalHeight,
                  width: double.infinity,
                  child: const LocationPickerBottomSheet(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SizedBox(
      height: 50 * scale,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => _showLocationPicker(context),
              borderRadius: BorderRadius.circular(12 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        strings.location,
                        style: AppTypography.label4(const Color(0xFF9AA3AF))
                            .copyWith(
                              fontSize: 12 * scale,
                              height: 1.25,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(width: 5 * scale),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16 * scale,
                        color: AppColors.brandMaroon,
                      ),
                    ],
                  ),
                  SizedBox(height: 5 * scale),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MarnAssetIcon(MarnIconAssets.location, size: 22 * scale),
                      SizedBox(width: 6 * scale),
                      Flexible(
                        child: Text(
                          strings.dohaQatar,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.paragraph2(
                                const Color(0xFF111827),
                              ).copyWith(
                                fontSize: 16 * scale,
                                height: 1.25,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _LanguageButton(scale: scale),
          SizedBox(width: 8 * scale),
          _NotificationButton(scale: scale),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationsCubit, Locale>(
      builder: (context, locale) {
        final strings = context.strings;
        final nextCode = locale.languageCode == 'ar' ? 'en' : 'ar';
        final label = locale.languageCode == 'ar'
            ? strings.switchToEnglish
            : strings.switchToArabic;

        return Padding(
          padding: EdgeInsets.only(top: 20 * scale),
          child: InkWell(
            onTap: () =>
                context.read<LocalizationsCubit>().setLanguage(nextCode),
            borderRadius: BorderRadius.circular(8 * scale),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4 * scale),
              child: Text(
                label,
                style: GoogleFonts.notoSansArabic(
                  fontSize: 16 * scale,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandMaroon,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRouter.notifications),
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 44 * scale,
        height: 44 * scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.baseWhite,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.notifications_none_rounded,
                size: 24 * scale,
                color: const Color(0xFF111827),
              ),
            ),
            Positioned(
              top: 8 * scale,
              right: 9 * scale,
              child: Container(
                width: 7 * scale,
                height: 7 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFE12238),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.baseWhite,
                    width: 1.2 * scale,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoCarousel extends StatefulWidget {
  const _PromoCarousel({required this.promo, required this.scale});

  final HomePromo promo;
  final double scale;

  @override
  State<_PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<_PromoCarousel> {
  late final PageController _pageController;
  late int _activeIndex;

  int get _slideCount {
    return widget.promo.totalSlides < 1 ? 1 : widget.promo.totalSlides;
  }

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.promo.currentSlide.clamp(0, _slideCount - 1).toInt();
    _pageController = PageController(
      initialPage: _activeIndex,
      viewportFraction: .96,
    );
  }

  @override
  void didUpdateWidget(covariant _PromoCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_activeIndex >= _slideCount) {
      _activeIndex = _slideCount - 1;
      _pageController.jumpToPage(_activeIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150 * widget.scale,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _slideCount,
        onPageChanged: (index) => setState(() => _activeIndex = index),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * widget.scale),
            child: _PromoCard(
              promo: widget.promo,
              scale: widget.scale,
              activeSlide: _activeIndex,
            ),
          );
        },
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({
    required this.promo,
    required this.scale,
    required this.activeSlide,
  });

  final HomePromo promo;
  final double scale;
  final int activeSlide;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      height: 150 * scale,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandMaroon,
        borderRadius: BorderRadius.circular(14 * scale),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12 * scale,
            top: 0,
            bottom: 0,
            width: 140 * scale,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.baseWhite,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(88 * scale),
                  right: Radius.circular(14 * scale),
                ),
              ),
            ),
          ),
          Positioned(
            right: 19 * scale,
            bottom: 10 * scale,
            child: _PromoPersonIllustration(scale: scale),
          ),
          Positioned(
            left: 17 * scale,
            top: 46 * scale,
            width: 198 * scale,
            child: Text(
              strings.homePromoTitle,
              style: AppTypography.paragraph2(AppColors.baseWhite).copyWith(
                fontSize: 16 * scale,
                height: 1.35,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 17 * scale,
            top: 106 * scale,
            child: Text(
              strings.homePromoSubtitle,
              style: AppTypography.paragraph4(
                AppColors.baseWhite,
              ).copyWith(fontSize: 12 * scale, height: 1.25),
            ),
          ),
          Positioned(
            left: 140 * scale,
            bottom: 13 * scale,
            child: Row(
              children: [
                for (var i = 0; i < promo.totalSlides; i++) ...[
                  Container(
                    width: i == activeSlide ? 26 * scale : 8 * scale,
                    height: 6 * scale,
                    decoration: BoxDecoration(
                      color: AppColors.baseWhite.withValues(
                        alpha: i == activeSlide ? .92 : .35,
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  if (i != promo.totalSlides - 1) SizedBox(width: 6 * scale),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoPersonIllustration extends StatelessWidget {
  const _PromoPersonIllustration({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82 * scale,
      height: 125 * scale,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 22 * scale,
              backgroundColor: const Color(0xFFE7DDD0),
              child: Icon(
                Icons.person_rounded,
                color: const Color(0xFF273746),
                size: 34 * scale,
              ),
            ),
          ),
          Positioned(
            bottom: 17 * scale,
            child: Container(
              width: 70 * scale,
              height: 62 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF0E344D),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28 * scale),
                  bottom: Radius.circular(10 * scale),
                ),
              ),
            ),
          ),
          Positioned(
            right: 7 * scale,
            bottom: 39 * scale,
            child: Transform.rotate(
              angle: -0.16,
              child: Icon(
                Icons.smartphone_rounded,
                color: const Color(0xFF111827),
                size: 32 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid({required this.services, required this.scale});

  final List<HomeServiceCategory> services;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.services,
          style: AppTypography.paragraph2(const Color(0xFF1F2937)).copyWith(
            fontSize: 16 * scale,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        GridView.builder(
          itemCount: services.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top / 2,
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 6 * scale,
            childAspectRatio: 105 / 99,
          ),
          itemBuilder: (context, index) {
            final service = services[index];
            return _ServiceCard(
              service: service,
              scale: scale,
              label: strings.serviceTitle(service.id, service.title),
              onTap: () => context.push(service.routePath),
            );
          },
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.service,
    required this.scale,
    required this.label,
    required this.onTap,
  });

  final HomeServiceCategory service;
  final double scale;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15 * scale),
      child: Column(
        children: [
          Opacity(
            opacity: .75,
            child: Container(
              width: 105 * scale,
              height: 75 * scale,
              decoration: BoxDecoration(
                color: AppColors.baseWhite,
                borderRadius: BorderRadius.circular(15 * scale),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                  width: .5 * scale,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.baseBlack.withValues(alpha: .05),
                    blurRadius: 5 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 54 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(
                        color: AppColors.brandBeige,
                        borderRadius: BorderRadius.circular(18 * scale),
                      ),
                    ),
                    Icon(
                      _iconForService(service.iconName),
                      size: 34 * scale,
                      color: AppColors.brandMaroon,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 6 * scale),
          SizedBox(
            width: 107 * scale,
            height: 18 * scale,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTypography.label4(const Color(0xFF717171)).copyWith(
                fontSize: 12 * scale,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForService(String iconName) {
    return switch (iconName) {
      'housemaid' => Icons.cleaning_services_outlined,
      'housemaid_local' => Icons.person_pin_circle_outlined,
      'travel' => Icons.mosque_outlined,
      'event' => Icons.celebration_outlined,
      'ads' => Icons.campaign_outlined,
      'services' => Icons.business_outlined,
      'home_projects' => Icons.storefront_outlined,
      'laundry' => Icons.local_laundry_service_outlined,
      'car' => Icons.car_repair_outlined,
      _ => Icons.category_outlined,
    };
  }
}
