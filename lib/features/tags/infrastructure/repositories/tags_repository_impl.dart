import 'package:lead_center/features/tags/domain/domain.dart';

class TagsRepositoryImpl extends TagsRepository {
  
  final TagsDatasource datasource;

  TagsRepositoryImpl(this.datasource);
  
  @override
  Future<Tag> createUpdateTag(Map<String, dynamic> tagLike) {
    return datasource.createUpdateTag(tagLike);
  }

  @override
  Future<Tag> getTagById(int id) {
    return datasource.getTagById(id);
  }

  @override
  Future<List<Tag>> getTagsByPage({int limit = 10, int offset = 0}) {
    return datasource.getTagsByPage( limit: limit, offset: offset );
  }

  @override
  Future<List<Tag>> searchTagByTerm(String term) {
    return datasource.searchTagByTerm(term);
  }
  
}