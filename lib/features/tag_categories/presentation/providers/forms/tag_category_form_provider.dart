import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:lead_center/features/shared/infrastructure/inputs/inputs.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';

final tagCategoryFormProvider  = StateNotifierProvider.autoDispose.family<TagCategoryFormNotifier, TagCategoryFormState, TagCategory>(
  (ref, tagCategory) {
    
    // final createUpdateCallback = ref.watch( tagCategoriesRepositoryProvider ).createUpdateTagCategory;
    final createUpdateCallback = ref.watch( tagCategoriesProvider.notifier ).createOrUpdateTagCategory;

    return TagCategoryFormNotifier(
      tagCategory: tagCategory,
      onSubmitCallback: createUpdateCallback,
    );
  }
);

class TagCategoryFormNotifier extends StateNotifier<TagCategoryFormState> {

  final Future<bool> Function( Map<String, dynamic> tagCategoryLike )? onSubmitCallback;

  TagCategoryFormNotifier({
    this.onSubmitCallback,
    required TagCategory tagCategory,
  }): super (
    TagCategoryFormState(
      id: tagCategory.id,
      name: Name.dirty(tagCategory.name),
    )
  );

  void onNameChanged( String value ) {
    state = state.copyWith(
      name: Name.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(value),
      ])
    );
  }

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    //TODO: regresar
    if ( onSubmitCallback == null ) return false;

    final tagCategoryLike = {
      'id': (state.id == 0),
      'name': state.name.value
    };

    try {
      return await onSubmitCallback!(tagCategoryLike);
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
}

class TagCategoryFormState {

  final bool isFormValid;
  final int? id;
  final Name name;

  TagCategoryFormState({ 
    this.isFormValid = false,
    this.id,
    this.name = const Name.dirty(''),
  });

  TagCategoryFormState copyWith({
    bool? isFormValid,
    int? id,
    Name? name,
  }) => TagCategoryFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
  );
}