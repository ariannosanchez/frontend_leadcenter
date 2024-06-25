import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/infrastructure/infrastructure.dart';

class TagCategoriesDatasourceImpl extends TagCategoriesDatasource {

  late final Dio dio;
  final String accessToken;

  TagCategoriesDatasourceImpl({
    required this.accessToken
  }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );


  @override
  Future<TagCategory> createUpdateTagCategory(Map<String, dynamic> tagCategoryLike) {
    // TODO: implement createUpdateTagCategory
    throw UnimplementedError();
  }

  @override
  Future<List<TagCategory>> getTagCategoriesByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/tag-categories?limit=$limit&offset=$offset');
    final List<TagCategory> tagCategories = [];
    for (final tagCategory in response.data ?? []) {
      tagCategories.add( TagCategoryMapper.tagCategoryJsonToEntity(tagCategory) );
    }

    return tagCategories;
  }

  @override
  Future<TagCategory> getTagCategoryById(String id) {
    // TODO: implement getTagCategoryById
    throw UnimplementedError();
  }

  @override
  Future<List<TagCategory>> searchTagCategoryByTerm(String term) {
    // TODO: implement searchTagCategoryByTerm
    throw UnimplementedError();
  }
  
}