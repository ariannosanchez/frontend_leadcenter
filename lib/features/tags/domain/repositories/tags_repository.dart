import 'package:lead_center/features/tags/domain/domain.dart';

abstract class TagsRepository {
  Future<List<Tag>> getTagsByPage({int limit = 10, int offset = 0});
  Future<Tag> getTagById(int id);
  Future<List<Tag>> searchTagByTerm(String term);
  Future<Tag> createUpdateTag(Map<String, dynamic> tagLike);
}
