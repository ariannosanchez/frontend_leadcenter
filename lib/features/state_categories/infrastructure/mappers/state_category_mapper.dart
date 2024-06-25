import 'package:lead_center/features/state_categories/domain/domain.dart';

class StateCategoryMapper {

  static stateCategoryJsonToEntity( Map<String, dynamic> json ) => StateCategory(
    id: json['id'],
    name: json['name'],
  );
}