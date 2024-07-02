import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

final tagProvider = StateNotifierProvider.autoDispose.family<TagNotifier, TagState, int>(
  (ref, tagId){
    
  final tagsRepository = ref.watch(tagsRepositoryProvider);

  return TagNotifier(
    tagsRepository: tagsRepository,
    tagId: tagId
  );
});

class TagNotifier extends StateNotifier<TagState> {

  final TagsRepository tagsRepository;

  TagNotifier({
    required this.tagsRepository,
    required int tagId
  }): super(TagState(id: tagId)) {
    loadTag();
  }

  Tag newEmptyTag() {
    return Tag(
      id: 0,
      name: '',
      tagCategory: TagCategory(id: 0, name: ''),
    );
  }

  Future<void> loadTag() async {
    try {

      if (state.id == 0) {
        state = state.copyWith(
          isLoading: false,
          tag: newEmptyTag(),
        );
        return;
      }

      final tag = await tagsRepository.getTagById(state.id);

      state = state.copyWith(
        isLoading: false,
        tag: tag,
      );
    } catch (e) {
      print(e);
    }
  }
}


class TagState {

  final int id;
  final Tag? tag;
  final bool isLoading;
  final bool isSaving;

  TagState({
    required this.id,
    this.tag,
    this.isLoading = true,
    this.isSaving = false,
  });

  TagState copyWith({
    int? id,
    Tag? tag,
    bool? isLoading,
    bool? isSaving,
  }) => TagState(
    id: id ?? this.id,
    tag: tag ?? this.tag,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
}