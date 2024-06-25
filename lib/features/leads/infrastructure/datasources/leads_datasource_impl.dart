import 'package:dio/dio.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/infrastructure/infraestructure.dart';

class LeadsDatasourceImpl extends LeadsDatasource {
  
  late final Dio dio;
  final String accessToken;

  LeadsDatasourceImpl({
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
  Future<Lead> createUpdateLead(Map<String, dynamic> leadLike) {
    // TODO: implement createUpdateLead
    throw UnimplementedError();
  }

  @override
  Future<Lead> getLeadById(String id) async {
    try {
      final response = await dio.get('/leads/$id');
      final lead = LeadMapper.leadJsonToEntity(response.data);
      return lead;

    } on DioException catch (e) {
      if (e.response!.statusCode == 404 ) throw LeadNotFound();
      throw Exception();

    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<List<Lead>> getLeadsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/leads?limit=$limit&offset=$offset');
    final List<Lead> leads = [];
    for (final lead in response.data ?? []) {
      leads.add( LeadMapper.leadJsonToEntity(lead) );
    }

    return leads;
  }

  @override
  Future<List<Lead>> searchLeadByTerm(String term) {
    // TODO: implement searchLeadByTerm
    throw UnimplementedError();
  }

}

