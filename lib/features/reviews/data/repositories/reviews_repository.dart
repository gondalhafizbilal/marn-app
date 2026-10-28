import 'package:marn/features/reviews/data/models/review_models.dart';

class ReviewsRepository {
  Future<List<Review>> getReviews(String targetId) async {
    await Future<void>.delayed(const Duration(milliseconds: 160));
    return const [
      Review(
        id: 'rev-1',
        author: 'Aisha',
        rating: 5,
        body: 'Professional, punctual, and easy to book again.',
      ),
      Review(
        id: 'rev-2',
        author: 'Khalid',
        rating: 4,
        body: 'Clear communication and good service quality.',
      ),
    ];
  }

  Future<void> submitReview(ReviewDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
  }
}
