import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'leads_repository_provider.dart';


final leadProvider = StateNotifierProvider.autoDispose.family<LeadNotifier, LeadState, String>(
  (ref, leadId) {
  
  final leadsRepository = ref.watch(leadsRepositoryProvider);
    
  return LeadNotifier(
    leadsRepository: leadsRepository,
    leadId: leadId
  );
});


class LeadNotifier extends StateNotifier<LeadState> {

  final LeadsRepository leadsRepository;

  LeadNotifier({
    required this.leadsRepository,
    required String leadId,
  }): super(LeadState(id: leadId )) {
    loadLead();
  }

  Future<void> loadLead() async {

    try {
      final lead = await leadsRepository.getLeadById(state.id);

      state =  state.copyWith(
        isLoading: false,
        lead: lead,
      );
    } catch (e) {
      // 404 lead not found
      print(e);
    }

  }

}

class LeadState {

  final String id;
  final Lead? lead;
  final bool isLoading;
  final bool isSaving;

  LeadState({
    required this.id, 
    this.lead, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  LeadState copyWith({
    String? id,
    Lead? lead,
    bool? isLoading,
    bool? isSaving,
  }) => LeadState(
    id: id ?? this.id,
    lead: lead ?? this.lead,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );


}