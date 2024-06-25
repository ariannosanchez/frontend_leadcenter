import 'package:lead_center/features/state_categories/domain/domain.dart';

abstract class StateCategoriesRepository {
  
  Future<List<StateCategory>> getStateCategoriesByPage({ int limit = 10, int offset = 0 });
  Future<StateCategory> getStateCategoryById( String id );

  Future<List<StateCategory>> searchStateCategoryByTerm( String term );

  Future<StateCategory> createUpdateStateCategory( Map<String, dynamic> stateCategoryLike );

}