import 'package:lead_center/features/charts/domain/domain.dart';

class LeadsChartRepositoryImpl extends LeadsChartRepository {
  
  final LeadsChartDatasource datasource;

  LeadsChartRepositoryImpl(this.datasource);
  
  @override
  Future<List<LeadChart>> getLeadsReport() {
    return datasource.getLeadsReport();
  } 
  
}