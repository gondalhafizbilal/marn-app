import 'package:marn/features/post_ad/data/models/post_ad_models.dart';

class PostAdRepository {
  Future<void> submitDraft(PostAdDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
