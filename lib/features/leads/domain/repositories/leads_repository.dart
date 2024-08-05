import 'package:lead_center/features/leads/domain/domain.dart';


abstract class LeadsRepository {

  Future<List<Lead>> getLeadsByPage({ int limit = 10, int offset = 0 });
  
  Future<Lead> getLeadById( String id );

  Future<List<Lead>> searchLeadByTerm( String term );

  Future<Lead> createUpdateLead( Map<String, dynamic> leadLike );

  Future<List<Lead>> searchLeads( String query );

  Future<List<Lead>> getLeadsByFilter({ String? startDate, String? endDate, int? stageId, int? tagId, int limit = 10, int offset = 0 });

}