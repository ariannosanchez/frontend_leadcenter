

import 'package:lead_center/features/leads/domain/domain.dart';

class LeadsRepositoryImpl extends LeadsRepository {

  final LeadsDatasource datasource;

  LeadsRepositoryImpl(this.datasource);

  @override
  Future<Lead> createUpdateLead(Map<String, dynamic> leadLike) {
    return datasource.createUpdateLead(leadLike);
  }

  @override
  Future<Lead> getLeadById(String id) {
    return datasource.getLeadById(id);
  }

  @override
  Future<List<Lead>> getLeadsByPage({int limit = 10, int offset = 0}) {
    return datasource.getLeadsByPage( limit: limit, offset: offset );
  }
  
  @override
  Future<List<Lead>> searchLeadByTerm(String term) {
    // TODO: implement searchLeadByTerm
    throw UnimplementedError();
  }
  
  @override
  Future<List<Lead>> searchLeads(String query) {
    return datasource.searchLeads( query );
  }
  
  @override
  Future<List<Lead>> getLeadsByFilter({ String? startDate, String? endDate, int? stageId, int? tagId, int limit = 10, int offset = 0}) {
    return datasource.getLeadsByFilter( startDate: startDate, endDate: endDate, stageId: stageId, tagId: tagId, limit: limit, offset: offset );
  }
  
  @override
  Future<List<Lead>> getLeadsByStage(int stageId) {
    return datasource.getLeadsByStage(stageId);
  }

}