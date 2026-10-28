import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/foundation/logic/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: state.slides.length,
                onPageChanged: context.read<OnboardingCubit>().setPage,
                itemBuilder: (context, index) {
                  final slide = state.slides[index];
                  return Image.asset(
                    slide.imageAsset,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
              Positioned(
                right: 28.w,
                bottom: 52.h,
                width: 150.w,
                height: 64.h,
                child: Semantics(
                  label: strings.onboardingSemanticsSkipAds,
                  button: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.onFinished,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
