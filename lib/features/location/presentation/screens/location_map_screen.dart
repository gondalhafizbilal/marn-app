import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_icon_assets.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/location/data/models/marn_location.dart';
import 'package:marn/features/location/logic/location_cubit.dart';
import 'package:marn/routing/app_router.dart';

class LocationMapScreen extends StatelessWidget {
  const LocationMapScreen({super.key, required this.useCurrentLocation});

  final bool useCurrentLocation;

  static const _designWidth = 375.0;
  static const _fallbackLocation = MarnLocation(
    title: 'location-details',
    address: 'sample-address',
    latitude: 25.2854,
    longitude: 51.5310,
  );

  Future<void> _confirm(BuildContext context) async {
    final cubit = context.read<LocationCubit>();
    if (useCurrentLocation) {
      await cubit.useCurrentLocation();
    } else {
      await cubit.selectManualLocation();
    }
    if (context.mounted) {
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final strings = context.strings;
        final location = state.location ?? _fallbackLocation;

        return Scaffold(
          backgroundColor: AppColors.brandBeige,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : _designWidth;
              final scale = width / _designWidth;

              return SizedBox(
                width: width,
                height: constraints.maxHeight,
                child: useCurrentLocation
                    ? _StandaloneMapLayout(
                        location: location,
                        isSaving: state.status == LocationStatus.loading,
                        scale: scale,
                        onBack: () => context.pop(),
                        onConfirm: () => _confirm(context),
                      )
                    : _HomeLocationLayout(
                        location: location,
                        isSaving: state.status == LocationStatus.loading,
                        scale: scale,
                        strings: strings,
                        onConfirm: () => _confirm(context),
                      ),
              );
            },
          ),
        );
      },
    );
  }
}

class LocationPickerBottomSheet extends StatelessWidget {
  const LocationPickerBottomSheet({super.key});

  Future<void> _confirm(BuildContext context) async {
    final cubit = context.read<LocationCubit>();
    await cubit.selectManualLocation();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final strings = context.strings;
        final location = state.location ?? LocationMapScreen._fallbackLocation;

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : LocationMapScreen._designWidth;
            final height = constraints.maxHeight.isFinite
                ? constraints.maxHeight
                : 565.0;
            final scale = width / LocationMapScreen._designWidth;
            const designHeight = 565.0;
            final verticalScale = (height / designHeight).clamp(.72, 1.0);
            final contentHeight = designHeight * verticalScale;
            final needsScroll = height < designHeight;

            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28 * scale),
              ),
              child: Material(
                color: AppColors.baseWhite,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    physics: needsScroll
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: contentHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _MapBackground(
                              scale: scale,
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          Positioned(
                            left: 24 * scale,
                            right: 24 * scale,
                            top: 49 * verticalScale,
                            height: 50 * verticalScale,
                            child: _LocationSearchField(scale: scale),
                          ),
                          Positioned(
                            left: width * .5 - 32,
                            top: contentHeight * .36,
                            child: const _MapPin(),
                          ),
                          Positioned(
                            left: 24 * scale,
                            right: 24 * scale,
                            top: 323 * verticalScale,
                            height: 117 * verticalScale,
                            child: _LocationDetailsCard(
                              location: location,
                              scale: scale,
                            ),
                          ),
                          Positioned(
                            left: 24 * scale,
                            right: 24 * scale,
                            top: 461 * verticalScale,
                            height: 52 * verticalScale,
                            child: _UpdateLocationButton(
                              label: state.status == LocationStatus.loading
                                  ? strings.updating
                                  : strings.updateLocation,
                              onPressed: state.status == LocationStatus.loading
                                  ? null
                                  : () => _confirm(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _HomeLocationLayout extends StatelessWidget {
  const _HomeLocationLayout({
    required this.location,
    required this.isSaving,
    required this.scale,
    required this.strings,
    required this.onConfirm,
  });

  final MarnLocation location;
  final bool isSaving;
  final double scale;
  final AppStrings strings;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: AppColors.brandBeige)),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24 * scale, 14 * scale, 24 * scale, 0),
            child: Column(
              children: [
                _LocationTopBar(scale: scale),
                SizedBox(height: 17 * scale),
                _MiniPromoCard(scale: scale),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 248 * scale,
          bottom: 0,
          child: _MapPanel(
            location: location,
            scale: scale,
            buttonLabel: isSaving ? strings.updating : strings.updateLocation,
            onConfirm: isSaving ? null : onConfirm,
          ),
        ),
      ],
    );
  }
}

class _StandaloneMapLayout extends StatelessWidget {
  const _StandaloneMapLayout({
    required this.location,
    required this.isSaving,
    required this.scale,
    required this.onBack,
    required this.onConfirm,
  });

  final MarnLocation location;
  final bool isSaving;
  final double scale;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Stack(
      children: [
        Positioned.fill(
          child: _MapBackground(scale: scale, borderRadius: BorderRadius.zero),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.all(20 * scale),
            child: IconButton(
              onPressed: onBack,
              icon: const MarnAssetIcon(MarnIconAssets.arrowLeft, size: 24),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.baseWhite.withValues(alpha: .78),
              ),
            ),
          ),
        ),
        Positioned(
          left: 24 * scale,
          right: 24 * scale,
          top: 112 * scale,
          child: const _LocationSearchField(),
        ),
        Positioned(
          left: 40 * scale,
          right: 40 * scale,
          bottom: 136 * scale,
          child: _LocationDetailsCard(location: location, scale: scale),
        ),
        Positioned(
          left: 24 * scale,
          right: 24 * scale,
          bottom: 48 * scale,
          child: _UpdateLocationButton(
            label: isSaving ? strings.saving : strings.confirmLocation,
            onPressed: isSaving ? null : onConfirm,
          ),
        ),
      ],
    );
  }
}

class _LocationTopBar extends StatelessWidget {
  const _LocationTopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return SizedBox(
      height: 50 * scale,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                  children: [
                    MarnAssetIcon(MarnIconAssets.location, size: 22 * scale),
                    SizedBox(width: 6 * scale),
                    Text(
                      strings.dohaQatar,
                      style: AppTypography.paragraph2(const Color(0xFF111827))
                          .copyWith(
                            fontSize: 16 * scale,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20 * scale),
            child: Text(
              'العربية',
              style: GoogleFonts.notoSansArabic(
                fontSize: 16 * scale,
                height: 1.25,
                fontWeight: FontWeight.w800,
                color: AppColors.brandMaroon,
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          SizedBox(
            width: 44 * scale,
            height: 44 * scale,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.baseWhite,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD1D5DB)),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 24 * scale,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPromoCard extends StatelessWidget {
  const _MiniPromoCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Container(
      height: 150 * scale,
      width: double.infinity,
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
            right: 28 * scale,
            bottom: 24 * scale,
            child: Icon(
              Icons.person_pin_circle_rounded,
              color: const Color(0xFF0E344D),
              size: 88 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPanel extends StatelessWidget {
  const _MapPanel({
    required this.location,
    required this.scale,
    required this.buttonLabel,
    required this.onConfirm,
  });

  final MarnLocation location;
  final double scale;
  final String buttonLabel;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _MapBackground(
            scale: scale,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32 * scale),
            ),
          ),
        ),
        Positioned(
          left: 24 * scale,
          right: 24 * scale,
          top: 48 * scale,
          child: const _LocationSearchField(),
        ),
        Positioned(left: 206 * scale, top: 151 * scale, child: const _MapPin()),
        Positioned(
          left: 24 * scale,
          right: 24 * scale,
          bottom: 126 * scale,
          child: _LocationDetailsCard(location: location, scale: scale),
        ),
        Positioned(
          left: 24 * scale,
          right: 24 * scale,
          bottom: 52 * scale,
          child: _UpdateLocationButton(
            label: buttonLabel,
            onPressed: onConfirm,
          ),
        ),
      ],
    );
  }
}

class _LocationSearchField extends StatelessWidget {
  const _LocationSearchField({this.scale = 1});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: strings.searchLocation,
        hintStyle: AppTypography.paragraph3(
          const Color(0xFFA3ADB8),
        ).copyWith(fontSize: 14 * scale, height: 18 / 14),
        prefixIcon: const Center(
          widthFactor: 1,
          heightFactor: 1,
          child: MarnAssetIcon(
            MarnIconAssets.search,
            color: AppColors.brandMaroon,
            size: 24,
          ),
        ),
        filled: true,
        fillColor: AppColors.baseWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFFD9DEE7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFFD9DEE7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: AppColors.brandMaroon),
        ),
        contentPadding: EdgeInsets.fromLTRB(
          16 * scale,
          12 * scale,
          16 * scale,
          12 * scale,
        ),
      ),
    );
  }
}

class _MapBackground extends StatelessWidget {
  const _MapBackground({required this.scale, required this.borderRadius});

  final double scale;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CustomPaint(
        painter: _MapPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFFAFAF8),
    );

    final roadPaint = Paint()
      ..color = const Color(0xFFE1E4EA)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final roadFillPaint = Paint()
      ..color = const Color(0xFFF7F7F7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final parkPaint = Paint()..color = const Color(0xFFD9F1DE);

    canvas.drawRect(
      Rect.fromLTWH(size.width * .56, size.height * .46, 76, 52),
      parkPaint,
    );

    final roads = <Path>[
      Path()
        ..moveTo(-20, size.height * .12)
        ..lineTo(size.width * .38, size.height * .32)
        ..lineTo(size.width + 20, size.height * .22),
      Path()
        ..moveTo(-20, size.height * .34)
        ..lineTo(size.width * .48, size.height * .48)
        ..lineTo(size.width + 20, size.height * .62),
      Path()
        ..moveTo(size.width * .2, -20)
        ..lineTo(size.width * .36, size.height * .38)
        ..lineTo(size.width * .3, size.height + 20),
      Path()
        ..moveTo(size.width * .8, -20)
        ..lineTo(size.width * .73, size.height * .55)
        ..lineTo(size.width * .84, size.height + 20),
      Path()
        ..moveTo(-20, size.height * .77)
        ..lineTo(size.width * .52, size.height * .68)
        ..lineTo(size.width + 20, size.height * .82),
    ];

    for (final path in roads) {
      canvas.drawPath(path, roadPaint);
      canvas.drawPath(path, roadFillPaint);
    }

    _drawLabel(
      canvas,
      'Jl. Keutamaan',
      Offset(size.width * .42, size.height * .2),
      -1.25,
    );
    _drawLabel(
      canvas,
      'Jl. Magelang',
      Offset(size.width * .08, size.height * .58),
      -1.45,
    );
    _drawLabel(
      canvas,
      'Jl. R. Bunyah Rejo',
      Offset(size.width * .57, size.height * .36),
      -1.35,
    );
    _drawLabel(
      canvas,
      'Jl. Pakuningratan',
      Offset(size.width * .33, size.height * .88),
      .04,
    );
  }

  void _drawLabel(Canvas canvas, String text, Offset offset, double angle) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(angle);
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return const MarnAssetIcon(MarnIconAssets.location, size: 64);
  }
}

class _LocationDetailsCard extends StatelessWidget {
  const _LocationDetailsCard({required this.location, required this.scale});

  final MarnLocation location;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final address = switch (location.address) {
      'sample-address' => strings.sampleAddress,
      'Doha, Qatar' => strings.dohaQatar,
      'Al Sadd, Doha' => strings.alSaddDoha,
      _ => location.address,
    };

    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: const Color(0xFFD9DEE7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.locationDetails,
            style: AppTypography.paragraph2(const Color(0xFF1F2937)).copyWith(
              fontSize: 16 * scale,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6 * scale),
          Expanded(
            child: Text(
              address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.paragraph4(const Color(0xFF98A1AF)).copyWith(
                fontSize: 12 * scale,
                height: 16 / 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateLocationButton extends StatelessWidget {
  const _UpdateLocationButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brandMaroon,
          foregroundColor: AppColors.baseWhite,
          disabledBackgroundColor: AppColors.brandMaroon.withValues(alpha: .6),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.paragraph2(
            AppColors.baseWhite,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
