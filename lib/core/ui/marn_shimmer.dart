import 'dart:math' as math;

import 'package:flutter/material.dart';

class MarnShimmer extends StatefulWidget {
  const MarnShimmer({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFF1F4F8),
    this.highlightColor = const Color(0xFFFFFFFF),
  });

  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<MarnShimmer> createState() => _MarnShimmerState();
}

class _MarnShimmerState extends State<MarnShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final width = bounds.width;
            final dx = (width * 2) * _controller.value - width;
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.25, 0.5, 0.75],
              transform: _SlidingGradientTransform(dx),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.dx);

  final double dx;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, 0.0, 0.0);
  }
}

class MarnShimmerBlock extends StatelessWidget {
  const MarnShimmerBlock({
    super.key,
    required this.width,
    required this.height,
    this.radius = 16,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return MarnShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class MarnShimmerLine extends StatelessWidget {
  const MarnShimmerLine({super.key, required this.width, this.height = 12});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MarnShimmerBlock(width: width, height: height, radius: height);
  }
}

class MarnShimmerAvatar extends StatelessWidget {
  const MarnShimmerAvatar({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return MarnShimmerBlock(
      width: size,
      height: size,
      radius: math.max(16, size / 2),
    );
  }
}
