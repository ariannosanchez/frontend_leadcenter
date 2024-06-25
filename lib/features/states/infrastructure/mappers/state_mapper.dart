import 'package:lead_center/features/state_categories/infrastructure/infrastructure.dart';
import 'package:lead_center/features/states/domain/domain.dart';

class StateMapper {

  static stateJsonToEntity( Map<String, dynamic> json ) => State(
    id: json['id'],
    name: json['name'],
    stateCategory: StateCategoryMapper
      .stateCategoryJsonToEntity( json['stateCategory'] ),
  );
}