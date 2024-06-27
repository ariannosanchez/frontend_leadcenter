import 'package:dio/dio.dart';
import 'package:lead_center/config/constants/environment.dart';
import 'package:lead_center/features/stage_categories/domain/domain.dart';
import 'package:lead_center/features/stage_categories/infrastructure/infrastructure.dart';

class StageCategoriesDatasourceImpl extends StageCategoriesDatasource {
  
  late final Dio dio;
  final String accessToken;

  StageCategoriesDatasourceImpl({
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
  Future<StageCategory> createUpdateStageCategory(Map<String, dynamic> stageCategoryLike) {
    // TODO: implement createUpdateStageCategory
    throw UnimplementedError();
  }
  
  @override
  Future<List<StageCategory>> getStageCategoriesByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/stage-categories?limit=$limit&offset=$offset');
    final List<StageCategory> stageCategories = [];
    for (final stageCategory in response.data ?? []) {
      stageCategories.add( StageCategoryMapper.stageCategoryJsonToEntity(stageCategory) );
    }
    return Future.value(stageCategories);
  }
  
  @override
  Future<StageCategory> getStageCategoryById(int id) {
    // TODO: implement getStageCategoryById
    throw UnimplementedError();
  }
  
  @override
  Future<List<StageCategory>> searchStageCategoryByTerm(String term) {
    // TODO: implement searchStageCategoryByTerm
    throw UnimplementedError();
  }

  
}