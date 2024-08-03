import 'package:lead_center/features/charts/domain/domain.dart';

class LeadChartMapper {
  
  static leadChartJsonToEntity( Map<String, dynamic> json )=> LeadChart(
    stage: json['stage'],
    count: json['count'],
  );

}