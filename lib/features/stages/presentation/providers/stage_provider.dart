import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/stage_categories/domain/domain.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';

final stageProvider = StateNotifierProvider.autoDispose.family<StageNotifier, StageState, int>(
  (ref, stageId){

  final stagesRepository = ref.watch(stagesRepositoryProvider);

  return StageNotifier(
    stagesRepository: stagesRepository, 
    stageId: stageId
  );
});

class StageNotifier extends StateNotifier<StageState> {

  final StagesRepository stagesRepository;
  
  StageNotifier({
    required this.stagesRepository,
    required int stageId
  }): super(StageState(id: stageId)) {
    loadStage();
  }

  Stage newEmptyStage() {
    return Stage(
      id: 0,
      name: '',
      stageCategory: StageCategory(id: 0, name: ''),
    );
  }

  Future<void> loadStage() async {
    try {
      
      if ( state.id == 0 ) {

        state = state.copyWith(
          isLoading: false,
          stage: newEmptyStage(),
        );
        return;
      }

      final stage = await stagesRepository.getStageById(state.id);

      state = state.copyWith(
        isLoading: false,
        stage: stage,
      );
    } catch (e) {
      print(e);
    }
  }
}

class StageState {

  final int id;
  final Stage? stage;
  final bool isLoading;
  final bool isSaving;

  StageState({
    required this.id,
    this.stage,
    this.isLoading = true,
    this.isSaving = false,
  });

  StageState copyWith({
    int ? id,
    Stage ? stage,
    bool ? isLoading,
    bool ? isSaving,
  }) => StageState(
    id: id ?? this.id,
    stage: stage ?? this.stage,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
}