import 'package:lead_center/features/stage_categories/domain/domain.dart';

abstract class StageCategoriesDatasource {
  
  Future<List<StageCategory>> getStageCategoriesByPage({ int limit = 10, int offset = 0 });
  Future<StageCategory> getStageCategoryById( int id );
  Future<List<StageCategory>> searchStageCategoryByTerm( String term );
  Future<StageCategory> createUpdateStageCategory( Map<String, dynamic> stageCategoryLike );
  
}