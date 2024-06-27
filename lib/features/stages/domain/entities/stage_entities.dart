import 'package:lead_center/features/stage_categories/domain/domain.dart';

class Stage {
  int id;
  String name;
  StageCategory stageCategory;

  Stage({
    required this.id,
    required this.name,
    required this.stageCategory
  });

}