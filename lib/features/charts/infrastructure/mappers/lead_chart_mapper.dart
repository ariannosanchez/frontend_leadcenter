import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/stages/infrastructure/infrastructure.dart';

class LeadChartMapper {
  
  static leadChartJsonToEntity( Map<String, dynamic> json )=> LeadChart(
    stage: StageMapper.stageJsonToEntity(json['stage']),
    count: json['count'],
  );

}