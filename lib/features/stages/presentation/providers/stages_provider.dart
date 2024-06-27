import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';

final stagesProvider = StateNotifierProvider<StagesNotifier, StagesState>((ref) {
  
  final stagesRepository = ref.watch( stagesRepositoryProvider );
  
  return StagesNotifier(
    stagesRepository: stagesRepository,
  );
});

class StagesNotifier extends StateNotifier<StagesState> {
  final StagesRepository stagesRepository;

  StagesNotifier({
    required this.stagesRepository
  }): super( StagesState() ) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );

    final stages = await stagesRepository
      .getStagesByPage( limit: state.limit, offset: state.offset );

    if ( stages.isEmpty ) {
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
      stages: [ ...state.stages, ...stages ] 
    );
  }
}

class StagesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Stage> stages;

  StagesState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.stages = const []
  });
  StagesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Stage>? stages,
  }) => StagesState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    stages: stages ?? this.stages,
  );
}