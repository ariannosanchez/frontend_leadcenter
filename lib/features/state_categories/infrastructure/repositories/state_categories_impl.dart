import 'package:lead_center/features/state_categories/domain/domain.dart';

class StateCategoriesRepositoryImpl extends StateCategoriesRepository {

  final StateCategoriesDatasource datasource;

  StateCategoriesRepositoryImpl(this.datasource);

  @override
  Future<StateCategory> createUpdateStateCategory(Map<String, dynamic> stateCategoryLike) {
    return datasource.createUpdateStateCategory(stateCategoryLike);
  }

  @override
  Future<StateCategory> getStateCategoryById(String id) {
    return datasource.getStateCategoryById(id);    
  }

  @override
  Future<List<StateCategory>> getStateCategoriesByPage({int limit = 10, int offset = 0}) {
    return datasource.getStateCategoriesByPage( limit: limit, offset: offset );
  }

  @override
  Future<List<StateCategory>> searchStateCategoryByTerm(String term) {
    return datasource.searchStateCategoryByTerm(term);
  }

}