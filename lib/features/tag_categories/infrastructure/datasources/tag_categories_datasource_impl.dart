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
  Future<TagCategory> createUpdateTagCategory(Map<String, dynamic> tagCategoryLike) async {
    
    try {

      final int? tagCategoryId = tagCategoryLike['id'];
      final String method = (tagCategoryId == null) ? 'POST' : 'PATCH';
      final String url = (tagCategoryId == null) ? '/tag-categories' : '/tag-categories/$tagCategoryId';
      
      tagCategoryLike.remove('id');
      
      final response = await dio.request(
        url,
        data: tagCategoryLike,
        options: Options(
          method: method,
        )
      );

      final tagCategory = TagCategoryMapper.tagCategoryJsonToEntity(response.data);
      return tagCategory;

    } catch (e) {
      throw Exception();
    }

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
  Future<TagCategory> getTagCategoryById(int id) async {
    try {
      final response = await dio.get('/tag-categories/$id');
      final tagCategory = TagCategoryMapper.tagCategoryJsonToEntity(response.data);
      return tagCategory;

    } on DioException catch (e) {
      if ( e.response!.statusCode == 404 ) throw TagCategoryNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<TagCategory>> searchTagCategoryByTerm(String term) {
    // TODO: implement searchTagCategoryByTerm
    throw UnimplementedError();
  }
  
}