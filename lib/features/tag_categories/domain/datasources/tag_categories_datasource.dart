import 'package:lead_center/features/tag_categories/domain/domain.dart';

abstract class TagCategoriesDatasource {
  
  Future<List<TagCategory>> getTagCategoriesByPage({ int limit = 10, int offset = 0 });
  Future<TagCategory> getTagCategoryById( int id );

  Future<List<TagCategory>> searchTagCategoryByTerm( String term );

  Future<TagCategory> createUpdateTagCategory( Map<String, dynamic> tagCategoryLike );

}