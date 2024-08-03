import 'package:lead_center/features/charts/domain/entities/lead_chart.dart';

abstract class LeadsChartRepository {
  
  Future<List<LeadChart>> getLeadsReport();

}