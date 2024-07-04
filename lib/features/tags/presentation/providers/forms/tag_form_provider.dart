import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:lead_center/features/shared/infrastructure/inputs/inputs.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

final tagFormProvider = StateNotifierProvider.autoDispose.family<TagFormNotifier, TagFormState, Tag>(
  (ref, tag) {

    // final createUpdateCallback = ref.watch( tagsRepositoryProvider ).createUpdateTag;
    final createUpdateCallback = ref.watch( tagsProvider.notifier ).createOrUpdateTag;

    return TagFormNotifier(
      tag: tag,
      onSubmitCallback: createUpdateCallback,
    );
  }
);


class TagFormNotifier extends StateNotifier<TagFormState> {

  final Future<bool> Function( Map<String, dynamic> tagLike )? onSubmitCallback;

  TagFormNotifier({
    this.onSubmitCallback,
    required Tag tag,
  }): super (
    TagFormState(
      id: tag.id,
      name: Name.dirty(tag.name),
      tagCategory: Number.dirty(tag.tagCategory.id)
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    if ( onSubmitCallback == null ) return false;

    final tagLike = {
      'id' : (state.id == 0) ? null : state.id,
      'name': state.name.value,
      'tagCategory': state.tagCategory.value
    };

    try {
      return await onSubmitCallback!( tagLike ); 

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
        Number.dirty(state.tagCategory.value),
      ])
    );
  }

  void onTagCategoryChanged( int value ) {
    state = state.copyWith(
      tagCategory: Number.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Number.dirty(state.tagCategory.value),
      ])
    );
  }

}


class TagFormState {
  
  final bool isFormValid;
  final int? id;
  final Name name;
  final Number tagCategory;

  TagFormState({
    this.isFormValid = false,
    this.id,
    this.name = const Name.dirty(''),
    this.tagCategory = const Number.dirty(0)
  });

  TagFormState copyWith({
    bool? isFormValid,
    int?  id,
    Name? name,
    Number? tagCategory,
  }) => TagFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
    tagCategory: tagCategory ?? this.tagCategory,
  );



}