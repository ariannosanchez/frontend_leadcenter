


import 'package:lead_center/features/leads/domain/domain.dart';

abstract class LeadsDatasource {

  Future<List<Lead>> getLeadsByPage({ int limit = 10, int offset = 0 }); 
  Future<Lead> getLeadById( String id );

  Future<List<Lead>> searchLeadByTerm( String term );

  Future<Lead> createUpdateLead( Map<String, dynamic> leadLike );

}
