import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/leads_repository_provider.dart';

final leadsProvider = StateNotifierProvider<LeadsNotifier, LeadsState>((ref) {
  
  final leadsRepository = ref.watch( leadsRepositoryProvider );
  
  return LeadsNotifier(
    leadsRepository: leadsRepository,
  );
});

class LeadsNotifier extends StateNotifier<LeadsState> {
  
  final LeadsRepository leadsRepository;

  LeadsNotifier({
    required this.leadsRepository
  }): super( LeadsState() ) {
    loadNextPage();
  }

  Future<bool> createOrUpdateLead( Map<String, dynamic> leadLike ) async {
    
    try {
      final lead = await leadsRepository.createUpdateLead(leadLike);
      final isLeadInList = state.leads.any((element) => element.id == lead.id );

      if ( !isLeadInList ) {
        state = state.copyWith(
          leads: [...state.leads, lead]
        );
        return true;
      }

      state = state.copyWith(
        leads: state.leads.map(
          (element) => ( element.id == lead.id ) ? lead : element,  
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }

  }

  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );

    final leads = await leadsRepository
      .getLeadsByFilter( 
        limit: state.limit,
        offset: state.offset,
        stageId: state.stageId,
        tagId: state.tagId,
        startDate: state.startDate?.toIso8601String(),
        endDate: state.endDate?.toIso8601String(),
      );

    if ( leads.isEmpty ) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      leads: [ ...state.leads, ...leads ] 
    );
  }

  Future<void> applyFilters({
    int? stageId,
    int? tagId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = state.copyWith(
      stageId: stageId,
      tagId: tagId,
      startDate: startDate,
      endDate: endDate,
      offset: 0,
      leads: [],
      isLastPage: false,
    );
    await loadNextPage();
  }

  void clearFilters() {
    state = state.copyWith(
      stageId: null,
      tagId: null,
      startDate: null,
      endDate: null,
      offset: 0,
      leads: [],
      isLastPage: false,
    );
  }

  Future<void> refreshLeads() async {
    state = state.copyWith(
      offset: 0,
      leads: [],
      isLastPage: false,
      //! Luego aqui agregar los filtos que se quieren aplicar
    );
    await loadNextPage();
  }

}

class LeadsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lead> leads;
  final int? stageId;
  final int? tagId;
  final DateTime? startDate;
  final DateTime? endDate;

  LeadsState({  
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0, 
    this.isLoading = false,
    this.leads = const[],
    this.stageId,
    this.tagId,
    this.startDate,
    this.endDate,
  });

  LeadsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lead>? leads,
    int? stageId,
    int? tagId,
    DateTime? startDate,
    DateTime? endDate,
  }) => LeadsState(
    isLastPage :  isLastPage ?? this. isLastPage,
    limit : limit ?? this.limit,
    offset : offset ?? this.offset,
    isLoading :  isLoading ?? this. isLoading,
    leads: leads ?? this.leads,
    stageId: stageId ?? this.stageId,
    tagId: tagId ?? this.tagId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
  );
}

  //! Metodos antiguos para los filtros de leads
  // void setFilters({ String? startDate, String? endDate, int? stageId, int? tagId}) {
  //   state = state.copyWith(
  //     selectedStageId: stageId,
  //     selectedTagId: tagId,
  //     selectedStartDate: startDate,
  //     selectedEndDate: endDate,
  //     offset: 0,
  //     leads: [],
  //     isLastPage: false,
  //   );
  //   loadNextPage();
  // }

  // void clearFilters() {
  //   state = state.copyWith(
  //     selectedStageId: 0,
  //     selectedTagId: 0,
  //     offset: 0,
  //     leads: [],
  //     isLastPage: false,
  //   );
  //   loadNextPage();
  // }
  //! Función que retorna la lista de leads
  // Future loadNextPage() async {

  //   if ( state.isLoading || state.isLastPage ) return;

  //   state = state.copyWith( isLoading: true );

  //   final leads = await leadsRepository
  //     .getLeadsByFilter( 
  //       limit: state.limit,
  //       offset: state.offset,
  //     );

  //   if ( leads.isEmpty ) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       isLastPage: true,
  //     );
  //     return;
  //   }

  //   state = state.copyWith(
  //     isLastPage: false,
  //     isLoading: false,
  //     offset: state.offset + 10,
  //     leads: [ ...state.leads, ...leads ] 
  //   );
  // }
