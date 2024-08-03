import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/charts/domain/domain.dart';
import 'package:lead_center/features/charts/presentation/providers/providers.dart';

final leadsChartProvider = StateNotifierProvider<LeadsChartNotifier, LeadsChartState>((ref) {
  
  final leadsChartRepository = ref.watch( leadsChartRepositoryProvider );

  return LeadsChartNotifier(
    leadsChartRepository: leadsChartRepository,
  );
});

class LeadsChartNotifier extends StateNotifier<LeadsChartState> {
  
  final LeadsChartRepository leadsChartRepository;

  LeadsChartNotifier({
    required this.leadsChartRepository
  }): super( LeadsChartState() ) {
    loadReport();
  }


  Future loadReport() async {
    if ( state.isLoading ) return;

    state = state.copyWith( isLoading: true );

    final leadsChart = await leadsChartRepository.getLeadsReport();

    if ( leadsChart.isEmpty ) {
      state = state.copyWith(
        isLoading: false,
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      leadsChart: [ ...state.leadsChart, ...leadsChart ]
    );
  }
}


class LeadsChartState {
  
  final bool isLoading;
  final List<LeadChart> leadsChart;

  LeadsChartState({
    this.isLoading = false,
    this.leadsChart = const [],
  });

  LeadsChartState copyWith({
    bool? isLoading,
    List<LeadChart>? leadsChart,
  }) => LeadsChartState(
    isLoading: isLoading ?? this.isLoading,
    leadsChart: leadsChart ?? this.leadsChart,
  );

}