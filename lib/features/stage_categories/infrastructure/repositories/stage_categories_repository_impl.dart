import 'package:lead_center/features/stage_categories/domain/domain.dart';

class StageCategoriesRepositoryImpl extends StageCategoriesRepository {
  
  final StageCategoriesDatasource datasource;

  StageCategoriesRepositoryImpl(this.datasource);
  
  @override
  Future<StageCategory> createUpdateStageCategory(Map<String, dynamic> stageCategoryLike) {
    return datasource.createUpdateStageCategory(stageCategoryLike);
  }
  
  @override
  Future<List<StageCategory>> getStageCategoriesByPage({int limit = 10, int offset = 0}) {
    return datasource.getStageCategoriesByPage( limit: limit, offset: offset );
  }
  
  @override
  Future<StageCategory> getStageCategoryById(int id) {
    return datasource.getStageCategoryById(id);
  }
  
  @override
  Future<List<StageCategory>> searchStageCategoryByTerm(String term) {
    return datasource.searchStageCategoryByTerm(term);
  }

  
}