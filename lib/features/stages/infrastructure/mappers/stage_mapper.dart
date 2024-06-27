import 'package:lead_center/features/stage_categories/infrastructure/infrastructure.dart';
import 'package:lead_center/features/stages/domain/domain.dart';

class StageMapper {
  static stageJsonToEntity( Map<String, dynamic> json ) => Stage(
    id: json['id'],
    name: json['name'],
    stageCategory: StageCategoryMapper
      .stageCategoryJsonToEntity( json['stageCategory'] ),
  );
}