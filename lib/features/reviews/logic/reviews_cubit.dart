import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/reviews/data/models/review_models.dart';
import 'package:marn/features/reviews/data/repositories/reviews_repository.dart';

class ReviewsState extends Equatable {
  const ReviewsState({this.isLoading = true, this.reviews = const []});

  final bool isLoading;
  final List<Review> reviews;

  ReviewsState copyWith({bool? isLoading, List<Review>? reviews}) {
    return ReviewsState(
      isLoading: isLoading ?? this.isLoading,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [isLoading, reviews];
}

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repository}) : super(const ReviewsState());

  final ReviewsRepository repository;

  Future<void> load(String targetId) async {
    final reviews = await repository.getReviews(targetId);
    emit(state.copyWith(isLoading: false, reviews: reviews));
  }
}
