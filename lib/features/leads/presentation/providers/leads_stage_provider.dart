import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';

final leadsStageProvider = StateNotifierProvider.autoDispose.family<LeadsStageNotifier, LeadsStageState, int>(
  (ref, stageId) {
  
  final leadsRepository = ref.watch( leadsRepositoryProvider );
  
  return LeadsStageNotifier(
    leadsRepository: leadsRepository,
    stageId: stageId
  );
});


class LeadsStageNotifier extends StateNotifier<LeadsStageState> {
  
  final LeadsRepository leadsRepository;

  LeadsStageNotifier({
    required this.leadsRepository,
    required int stageId, 
  }): super( LeadsStageState( stageId: stageId ) ) {
    loadNextPage();
  }


  Future loadNextPage() async {

    try {
      if ( state.isLoading || state.isLastPage ) return;

      state = state.copyWith( isLoading: true );

      final leads = await leadsRepository.getLeadsByStage(state.stageId);

      if ( leads.isEmpty ) {
        state = state.copyWith(
          isLoading: false,
          isLastPage: true,
        );
        return;
      }

      state = state.copyWith(
        isLoading: false,
        offset: state.offset + state.limit,
        leads: [...state.leads, ...leads],
      );
  
    } catch (e) {
      print(e);
    }
    
  }
 
}

class LeadsStageState {
  final int stageId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lead> leads;

  LeadsStageState({  
    required this.stageId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.leads = const[],
  });

  LeadsStageState copyWith({
    int ? stageId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lead>? leads,
  }) => LeadsStageState(
    stageId : stageId ?? this. stageId,
    isLastPage :  isLastPage ?? this. isLastPage,
    limit : limit ?? this.limit,
    offset : offset ?? this.offset,
    isLoading :  isLoading ?? this. isLoading,
    leads: leads ?? this.leads,
  );
}



