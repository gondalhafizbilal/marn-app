import 'package:marn/features/requests/data/models/request_models.dart';

class RequestsRepository {
  Future<List<MarnRequest>> getRequests() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return _requests;
  }

  Future<MarnRequest> getRequestPreview() async {
    await Future<void>.delayed(const Duration(milliseconds: 140));
    return _requests.first;
  }

  Future<MarnRequest> submitRequest(RequestDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return MarnRequest(
      id: 'req-new',
      title: draft.category,
      status: 'Submitted',
      provider: 'Matching providers',
      scheduledFor: draft.location,
    );
  }

  static const _requests = [
    MarnRequest(
      id: 'req-1',
      title: 'Weekly cleaning',
      status: 'Pending',
      provider: 'Doha Care Agency',
      scheduledFor: 'Tomorrow, 10:00 AM',
    ),
    MarnRequest(
      id: 'req-2',
      title: 'Event support',
      status: 'Completed',
      provider: 'Marn Events Pro',
      scheduledFor: 'July 5, 2026',
    ),
  ];
}
