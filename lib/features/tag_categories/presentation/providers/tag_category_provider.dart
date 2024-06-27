import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';

final tagCategoryProvider = StateNotifierProvider.autoDispose.family<TagCategoryNotifier, TagCategoryState, int>(
  (ref, tagCategoryId){

  final tagCategoriesRepository = ref.watch(tagCategoriesRepositoryProvider);

  return TagCategoryNotifier(
    tagCategoriesRepository: tagCategoriesRepository,
    tagCategoryId: tagCategoryId
  );
});

class TagCategoryNotifier extends StateNotifier<TagCategoryState> {

  final TagCategoriesRepository tagCategoriesRepository;

  TagCategoryNotifier({
    required this.tagCategoriesRepository,
    required int tagCategoryId,
  }): super(TagCategoryState(id: tagCategoryId)) {

  }

  Future<void> loadTagCategory() async {
    try {
      final tagCategory = await tagCategoriesRepository.getTagCategoryById(state.id);

      state = state.copyWith(
        isLoading: false,
        tagCategory: tagCategory,
      );
    } catch (e) {
      print(e);
    }
  }

}

class TagCategoryState {
  
  final int id;
  final TagCategory? tagCategory;
  final bool isLoading;
  final bool isSaving;

  TagCategoryState({
    required this.id,
    this.tagCategory,
    this.isLoading = true,
    this.isSaving = false,
  });

  TagCategoryState copyWith({
    int? id,
    TagCategory? tagCategory,
    bool? isLoading,
    bool? isSaving,
  }) => TagCategoryState(
    id: id ?? this.id,
    tagCategory: tagCategory ?? this.tagCategory,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );

}