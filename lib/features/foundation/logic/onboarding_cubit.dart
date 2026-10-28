import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/foundation/data/models/onboarding_slide.dart';
import 'package:marn/features/foundation/data/repositories/foundation_repository.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.slides, this.currentIndex = 0});

  final List<OnboardingSlide> slides;
  final int currentIndex;

  bool get isLastSlide => currentIndex >= slides.length - 1;

  OnboardingState copyWith({List<OnboardingSlide>? slides, int? currentIndex}) {
    return OnboardingState(
      slides: slides ?? this.slides,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [slides, currentIndex];
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.repository})
    : super(const OnboardingState(slides: []));

  final FoundationRepository repository;

  void load(AppStrings strings) {
    emit(state.copyWith(slides: repository.getOnboardingSlides(strings)));
  }

  void setPage(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
