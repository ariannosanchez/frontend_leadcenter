import 'package:lead_center/features/tag_categories/domain/domain.dart';

abstract class TagCategoriesRepository {
  
  Future<List<TagCategory>> getTagCategoriesByPage({ int limit = 10, int offset = 0 });
  Future<TagCategory> getTagCategoryById( String id );

  Future<List<TagCategory>> searchTagCategoryByTerm( String term );

  Future<TagCategory> createUpdateTagCategory( Map<String, dynamic> tagCategoryLike );

}