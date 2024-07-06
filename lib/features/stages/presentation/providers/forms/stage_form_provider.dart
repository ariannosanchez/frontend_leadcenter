import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';


final stageFormProvider = StateNotifierProvider.autoDispose.family<StageFormNotifier, StageFormState, Stage>(
  (ref, stage){
    
    final createUpdateCallback = ref.watch( stagesProvider.notifier ).createOrUpdateStage;

    return StageFormNotifier(
      stage: stage,
      onSubmitCallback: createUpdateCallback,
    );
  }
);


class StageFormNotifier extends StateNotifier<StageFormState> {

  final Future<bool> Function( Map<String, dynamic> stageLike )? onSubmitCallback;

  StageFormNotifier({
    this.onSubmitCallback,
    required Stage stage,
  }): super (
    StageFormState(
      id: stage.id,
      name: Name.dirty(stage.name),
      stageCategory: Number.dirty(stage.stageCategory.id)
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    if ( onSubmitCallback == null ) return false;

    final stageLike = {
      'id': (state.id == 0) ? null : state.id,
      'name': state.name.value,
      'stageCategory': state.stageCategory.value
    };

    try {
      return await onSubmitCallback!( stageLike );
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
      ]),
    );
  }


  void onNameChanged( String value ) {
    state = state.copyWith(
      name: Name.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(value),
        Number.dirty(state.stageCategory.value),
      ])
    );
  }

  void onStageCategoyChanged( int value ) {
    state = state.copyWith(
      stageCategory: Number.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Number.dirty(state.stageCategory.value),
      ])
    );
  }

}

class StageFormState {

  final bool isFormValid;
  final int? id;
  final Name name;
  final Number stageCategory;

  StageFormState({
    this.isFormValid = false,
    this.id,
    this.name = const Name.dirty(''),
    this.stageCategory = const Number.dirty(0)
  });

  StageFormState copyWith ({
  bool? isFormValid,
  int? id,
  Name? name,
  Number? stageCategory,
  }) => StageFormState (
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
    stageCategory: stageCategory ?? this.stageCategory,
  );

}



