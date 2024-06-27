import 'package:lead_center/features/stage_categories/domain/domain.dart';

class StageCategoryMapper {
  
  static StageCategory stageCategoryJsonToEntity( Map<String, dynamic> json ) => StageCategory(
    id: json['id'],
    name: json['name'],
  );

}