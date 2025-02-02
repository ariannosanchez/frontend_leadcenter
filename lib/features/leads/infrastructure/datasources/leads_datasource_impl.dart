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
  Future<Lead> createUpdateLead(Map<String, dynamic> leadLike) async {
    
    try {
      
      final String? leadId = leadLike['id'];
      final String method = (leadId == null) ? 'POST' : 'PATCH';
      final String url = (leadId == null) ? '/leads' : '/leads/$leadId';

      leadLike.remove('id');

      final response = await dio.request(
        url,
        data: leadLike,
        options: Options(
          method: method
        )
      );

      final lead = LeadMapper.leadJsonToEntity(response.data);
      return lead;

    } catch (e) {
      throw Exception();
    }

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
    try {
      final response = await dio.get<List>('/leads?limit=$limit&offset=$offset');
      final List<Lead> leads = [];
      for (final lead in response.data ?? []) {
        leads.add( LeadMapper.leadJsonToEntity(lead) );
      }

      return leads;
    } on DioException catch (e){
      if (e.response!.statusCode == 404 ) throw LeadNotFound();
      throw Exception();
      
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Lead>> getLeadsByFilter({ 
      String? startDate,
      String? endDate,
      int? stageId,
      int? tagId,
      int limit = 10,
      int offset = 0}) async {
    try {

      // String url = '/leads/search?limit=$limit&offset=$offset';
      // if ( startDate != '' ) url += '&startDate=$startDate';
      // if ( endDate != '' ) url += '&endDate=$endDate';
      // if ( stageId != 0  ) url += '&stageId=$stageId';
      // if ( tagId != 0 ) url += '&tagId=$tagId';

      final response = await dio.get<List>('/leads/search',
        queryParameters: {
          'limit': limit,
          'offset': offset,
          if (tagId != null) 'tagId': tagId,
          if (stageId != null) 'stageId': stageId,
          if (startDate != null) 'startDate': startDate,
          if (endDate != null) 'endDate': endDate
        }
      );
      final List<Lead> leads = [];
      for (final lead in response.data ?? []) {
        leads.add( LeadMapper.leadJsonToEntity(lead) );
      }
      print(response);
      return leads;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404 ) throw LeadNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Lead>> searchLeadByTerm(String term) {
    // TODO: implement searchLeadByTerm
    throw UnimplementedError();
  }
  
  @override
  Future<List<Lead>> searchLeads( String query) async {
    final response = await dio.get<List>('/leads/search', 
      queryParameters: { 
        'name': query
      }
    );
    final List<Lead> leads = [];
    for (final lead in response.data ?? []) {
      leads.add( LeadMapper.leadJsonToEntity(lead) );
    }

    return leads;
  }
  
  @override
  Future<List<Lead>> getLeadsByStage(int stageId) async {
    try {
      final response = await dio.get('/leads/stage/$stageId');
      final List<Lead> leads = [];
      for (final lead in response.data ?? []) {
        leads.add( LeadMapper.leadJsonToEntity(lead) );
      }
      return leads;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404 ) throw LeadNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
  
}

