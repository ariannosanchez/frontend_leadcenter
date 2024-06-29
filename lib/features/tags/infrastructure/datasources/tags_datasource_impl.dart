import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/infrastructure/errors/tag_error.dart';
import 'package:lead_center/features/tags/infrastructure/infrastructure.dart';

class TagsDatasourceImpl extends TagsDatasource {
  
  late  final Dio dio;  
  final String accessToken;

  TagsDatasourceImpl({
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
  Future<Tag> createUpdateTag(Map<String, dynamic> tagLike) async {
    
    try {
      
      final int? tagId = tagLike['id'];
      final String method = (tagId == null) ? 'POST' : 'PATCH';
      final String url = (tagId == null) ? '/tags' : '/tags/$tagId';

      tagLike.remove('id');

      final response = await dio.request(
        url,
        data: tagLike,
        options: Options(
          method: method,
        )
      );

      final tag = TagMapper.tagJsonToEntity(response.data);
      return tag;

    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<Tag> getTagById(int id) async {
    try {
      final response = await dio.get('/tags/$id');
      final tag = TagMapper.tagJsonToEntity(response.data);
      return tag;

    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw TagNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Tag>> getTagsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/tags?limit=$limit&offset=$offset');
    final List<Tag> tags = [];
    for (final tag in response.data ?? []) {
      tags.add( TagMapper.tagJsonToEntity(tag) );
    }
    return tags;
  }

  @override
  Future<List<Tag>> searchTagByTerm(String term) {
    // TODO: implement searchTagByTerm
    throw UnimplementedError();
  }
  
}