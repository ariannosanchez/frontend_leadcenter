import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/infrastructure/errors/stage_errror.dart';
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
  Future<Stage> createUpdateStage(Map<String, dynamic> stageLike) async {
    
    try {
      
      final int? stageId = stageLike['id'];
      final String method = (stageId == null) ? 'POST' : 'PATCH';
      final String url = (stageId == null) ? '/stages' : '/stages/$stageId';

      stageLike.remove('id');

      final response = await dio.request(
        url,
        data: stageLike,
        options: Options(
          method: method
        )
      );

      final stage = StageMapper.stageJsonToEntity(response.data);
      return stage;

    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<Stage> getStageById(int id) async {
    try {
      final response = await dio.get('/stages/$id');
      final stage = StageMapper.stageJsonToEntity(response.data);
      return stage;

    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw StageNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
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