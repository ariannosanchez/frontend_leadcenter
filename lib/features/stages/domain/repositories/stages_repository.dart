import 'package:lead_center/features/stages/domain/domain.dart';

abstract class StagesRepository {
  
  Future<List<Stage>> getStagesByPage({ int limit = 10, int offset = 0 });
  Future<Stage> getStageById( String id );
  Future<List<Stage>> searchStageByTerm( String term );
  Future<Stage> createUpdateStage( Map<String, dynamic> stageLike );
}