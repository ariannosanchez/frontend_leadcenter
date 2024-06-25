import 'package:lead_center/features/tag_categories/domain/domain.dart';

class TagCategoriesRepositoryImpl extends TagCategoriesRepository {

  final TagCategoriesDatasource datasource;

  TagCategoriesRepositoryImpl(this.datasource);

  @override
  Future<TagCategory> createUpdateTagCategory(Map<String, dynamic> tagCategoryLike) {
    return datasource.createUpdateTagCategory(tagCategoryLike);
  }

  @override
  Future<TagCategory> getTagCategoryById(String id) {
    return datasource.getTagCategoryById(id);
  }

  @override
  Future<List<TagCategory>> getTagCategoriesByPage({int limit = 10, int offset = 0}) {
    return datasource.getTagCategoriesByPage( limit: limit, offset: offset );
  }

  @override
  Future<List<TagCategory>> searchTagCategoryByTerm(String term) {
    return datasource.searchTagCategoryByTerm(term);
  }
  
}