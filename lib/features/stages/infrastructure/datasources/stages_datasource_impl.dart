import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/infrastructure/infrastructure.dart';

class StagesDatasourceImpl extends StagesDatasource {

  late final Dio dio;
  final String accessToken;

  StagesDatasourceImpl({
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
  Future<Stage> createUpdateStage(Map<String, dynamic> stageLike) {
    // TODO: implement createUpdateStage
    throw UnimplementedError();
  }

  @override
  Future<Stage> getStageById(String id) {
    // TODO: implement getStageById
    throw UnimplementedError();
  }

  @override
  Future<List<Stage>> getStagesByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/stages?limit=$limit&offset=$offset');
    final List<Stage> stages = [];
    for (final stage in response.data ?? []) {
      stages.add( StageMapper.stageJsonToEntity(stage) );
    }

    return stages;
  }

  @override
  Future<List<Stage>> searchStageByTerm(String term) {
    // TODO: implement searchStageByTerm
    throw UnimplementedError();
  }
  

}