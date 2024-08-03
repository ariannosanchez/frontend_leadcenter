
import 'package:lead_center/features/charts/domain/domain.dart';

abstract class LeadsChartDatasource {

    Future<List<LeadChart>> getLeadsReport();

}