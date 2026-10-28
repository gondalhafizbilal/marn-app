import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/reviews/data/models/review_models.dart';
import 'package:marn/features/reviews/data/repositories/reviews_repository.dart';

class ReviewFormState extends Equatable {
  const ReviewFormState({
    this.rating = 5,
    this.body = '',
    this.isSubmitting = false,
    this.isSubmitted = false,
  });

  final int rating;
  final String body;
  final bool isSubmitting;
  final bool isSubmitted;

  ReviewFormState copyWith({
    int? rating,
    String? body,
    bool? isSubmitting,
    bool? isSubmitted,
  }) {
    return ReviewFormState(
      rating: rating ?? this.rating,
      body: body ?? this.body,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [rating, body, isSubmitting, isSubmitted];
}

class ReviewFormCubit extends Cubit<ReviewFormState> {
  ReviewFormCubit({required this.repository}) : super(const ReviewFormState());

  final ReviewsRepository repository;

  void ratingChanged(int rating) => emit(state.copyWith(rating: rating));

  void bodyChanged(String body) => emit(state.copyWith(body: body));

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true));
    await repository.submitReview(
      ReviewDraft(rating: state.rating, body: state.body),
    );
    emit(state.copyWith(isSubmitting: false, isSubmitted: true));
  }
}
