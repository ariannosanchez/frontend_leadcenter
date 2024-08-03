import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/charts/infrastructure/infraestructure.dart';

class LeadsChartDatasourceImpl extends LeadsChartDatasource {
  
  late final Dio dio;
  final String accessToken;

  LeadsChartDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  @override
  Future<List<LeadChart>> getLeadsReport() async {
    try {
     final response = await dio.get<List>('/leads/funnel-report');
     final List<LeadChart> leadsChart = [];
      for (final leadChart in response.data ?? []) {
        leadsChart.add( LeadChartMapper.leadChartJsonToEntity(leadChart) );
      }
      
      return leadsChart;
    }on DioException catch (e) {
      if (e.response!.statusCode == 404) throw LeadChartNotFound();
      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }
  
}