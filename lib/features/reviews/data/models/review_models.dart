class Review {
  const Review({
    required this.id,
    required this.author,
    required this.rating,
    required this.body,
  });

  final String id;
  final String author;
  final int rating;
  final String body;
}

class ReviewDraft {
  const ReviewDraft({required this.rating, required this.body});

  final int rating;
  final String body;
}
