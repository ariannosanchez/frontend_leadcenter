import 'package:lead_center/features/stages/domain/domain.dart';

class StagesRepositoryImpl extends StagesRepository {

  final StagesDatasource datasource;

  StagesRepositoryImpl(this.datasource);

  @override
  Future<Stage> createUpdateStage(Map<String, dynamic> stageLike) {
    return datasource.createUpdateStage(stageLike);
  }

  @override
  Future<Stage> getStageById(int id) {
    return datasource.getStageById(id);
  }

  @override
  Future<List<Stage>> getStagesByPage({int limit = 10, int offset = 0}) {
    return datasource.getStagesByPage( limit: limit, offset: offset );
  }

  @override
  Future<List<Stage>> searchStageByTerm(String term) {
    return datasource.searchStageByTerm(term);
  }
  
}