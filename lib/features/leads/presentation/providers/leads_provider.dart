import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/leads_repository_provider.dart';

final leadsProvider = StateNotifierProvider<LeadsNotifier, LeadsState>((ref) {
  
  final leadsRepository = ref.watch( leadsRepositoryProvider );
  
  return LeadsNotifier(
    leadsRepository: leadsRepository,
  );
});

final selectedStageProvider = StateProvider<int?>((ref) => null);
final selectedTagProvider = StateProvider<int?>((ref) => null);
final selectedStartDate = StateProvider((ref) => null); 
final selectedEndDate = StateProvider((ref) => null); 

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

  void setFilters({ String? startDate, String? endDate, int? stageId, int? tagId}) {
    state = state.copyWith(
      selectedStageId: stageId,
      selectedTagId: tagId,
      selectedStartDate: startDate,
      selectedEndDate: endDate,
      offset: 0,
      leads: [],
      isLastPage: false,
    );
    loadNextPage();
  }

  void clearFilters() {
    state = state.copyWith(
      selectedStageId: 0,
      selectedTagId: 0,
      offset: 0,
      leads: [],
      isLastPage: false,
    );
    loadNextPage();
  }

  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );

    final leads = await leadsRepository
      .getLeadsByFilter( 
        limit: state.limit,
        offset: state.offset,
        stageId: state.selectedStageId,
        tagId: state.selectedTagId,
        startDate: state.selectedStartDate,
        endDate: state.selectedEndDate,
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
}

class LeadsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lead> leads;
  final int selectedStageId;
  final int selectedTagId;
  final String selectedStartDate;
  final String selectedEndDate;

  LeadsState({  
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.leads = const[],
    this.selectedStageId = 0,
    this.selectedTagId = 0,
    this.selectedEndDate = '',
    this.selectedStartDate = '',
  });

  LeadsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lead>? leads,
    int ? selectedStageId,
    int ? selectedTagId,
    String ? selectedStartDate,
    String ? selectedEndDate,
  }) => LeadsState(
    isLastPage :  isLastPage ?? this. isLastPage,
    limit : limit ?? this.limit,
    offset : offset ?? this.offset,
    isLoading :  isLoading ?? this. isLoading,
    leads: leads ?? this.leads,
    selectedStageId: selectedStageId ?? this.selectedStageId,
    selectedTagId: selectedTagId ?? this.selectedTagId,
    selectedStartDate: selectedStartDate ?? this.selectedStartDate,
    selectedEndDate: selectedEndDate ?? this.selectedEndDate
  );
}
