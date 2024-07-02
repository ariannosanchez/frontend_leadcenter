
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formz/formz.dart';
// import 'package:lead_center/features/shared/shared.dart';
// import 'package:lead_center/features/tag_categories/domain/domain.dart';
// import 'package:lead_center/features/tag_categories/infrastructure/infrastructure.dart';
// import 'package:lead_center/features/tags/domain/domain.dart';
// import 'package:lead_center/features/tags/presentation/providers/providers.dart';


// final tagFormProvider = StateNotifierProvider.autoDispose.family<TagFormNotifier, TagFormState, Tag>(
//   (ref, tag) {
//     final createUpdateCallback = ref.watch( tagsProvider.notifier ).createOrUpdateTag;
    
//     return TagFormNotifier(
//       tag : tag,
//       onSubmitCallback: createUpdateCallback,
//     );
//   }
// );


// class TagFormNotifier extends StateNotifier<TagFormState> {

//   final Future<bool> Function( Map<String, dynamic> tagLike )? onSubmitCallback;

//   TagFormNotifier({
//     this.onSubmitCallback,
//     required Tag tag,
//   }): super (
//     TagFormState(
//       id: tag.id,
//       name: Name.dirty(tag.name),
//       tagCategory: Number.dirty(tag.tagCategory.id),
//     )
//   );

//   void onNameChanged( String value ) {
//     state = state.copyWith(
//       name: Name.dirty(value),
//       isFormValid: Formz.validate([
//         Name.dirty(value),
//       ])
//     );
//   }

//   void onTagCategoryChanged( int value ) {
//     state = state.copyWith(
//       tagCategory: Number.dirty(value),
//       isFormValid: Formz.validate([
//         Number.dirty(value),
//       ])
//     );
//   }

//   Future<bool> onFormSubmit() async {
//     _touchedEverything();
//     if ( !state.isFormValid ) return false;

//     if ( onSubmitCallback == null ) return false;

//     final tagLike = {
//       'id': (state.id == 0),
//       'name': state.name.value,
//       'tagCategory': TagCategoryMapper.tagCategoryJsonToEntity( ),
//     };

//     try {
//       return await onSubmitCallback!(tagLike);
//     } catch (e) {
//       return false;
//     }
//   }


//   void _touchedEverything() {
//     state = state.copyWith(
//       isFormValid: Formz.validate([
//         Name.dirty(state.name.value),
//       ])
//     );
//   }

// }

// class TagFormState {

//   final bool isFormValid;
//   final int? id;
//   final Name name;
//   final TagCategory tagCategory;

//   TagFormState({
//     this.isFormValid = false, 
//     this.id,
//     this.name = const Name.dirty(''),
//     required this.tagCategory
//   });

//   TagFormState copyWith({
//     bool? isFormValid,
//     int? id,
//     Name? name,
//     dynamic tagCategory
//   }) {
//     return TagFormState(
//       isFormValid: isFormValid ?? this.isFormValid,
//       id: id ?? this.id,
//       name: name ?? this.name,
//       tagCategory: tagCategory ?? this.tagCategory
//     );
//   }
// }