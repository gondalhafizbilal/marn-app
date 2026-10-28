class MarnRequest {
  const MarnRequest({
    required this.id,
    required this.title,
    required this.status,
    required this.provider,
    required this.scheduledFor,
  });

  final String id;
  final String title;
  final String status;
  final String provider;
  final String scheduledFor;
}

class RequestDraft {
  const RequestDraft({
    required this.category,
    required this.description,
    required this.location,
  });

  final String category;
  final String description;
  final String location;
}
