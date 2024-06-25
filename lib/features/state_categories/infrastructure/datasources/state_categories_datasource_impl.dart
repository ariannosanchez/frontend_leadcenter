import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/state_categories/domain/domain.dart';
import 'package:lead_center/features/state_categories/infrastructure/infrastructure.dart';

class StateCategoriesDatasourceImpl extends StateCategoriesDatasource {

  late final Dio dio;
  final String accessToken;

  StateCategoriesDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );
  
  @override
  Future<StateCategory> createUpdateStateCategory(Map<String, dynamic> stateCategoryLike) {
    // TODO: implement createUpdateStateCategory
    throw UnimplementedError();
  }
  
  @override
  Future<List<StateCategory>> getStateCategoriesByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/state-categories?limit=$limit&offset=$offset');
    final List<StateCategory> stateCategories = [];
    for (final stateCategory in response.data ?? []) {
      stateCategories.add( StateCategoryMapper.stateCategoryJsonToEntity(stateCategory) );
    }

    return stateCategories;
  }
  
  @override
  Future<StateCategory> getStateCategoryById(String id) {
    // TODO: implement getStateCategoryById
    throw UnimplementedError();
  }
  
  @override
  Future<List<StateCategory>> searchStateCategoryByTerm(String term) {
    // TODO: implement searchStateCategoryByTerm
    throw UnimplementedError();
  }
  

}