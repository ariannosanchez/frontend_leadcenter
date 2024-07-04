import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';


final tagsProvider = StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  
  final tagsRepository = ref.watch( tagsRepositoryProvider );
  
  return TagsNotifier(
    tagsRepository: tagsRepository
  );
});


class TagsNotifier extends StateNotifier<TagsState> {
  
  final TagsRepository tagsRepository;

  TagsNotifier({
    required this.tagsRepository
  }) : super( TagsState() ) {
    loadNextPage();
  }

  Future<bool> createOrUpdateTag( Map<String, dynamic> tagLike ) async {
  
    try {
      final tag = await tagsRepository.createUpdateTag(tagLike);
      final isTagInList = state.tags.any((element) => element.id == tag.id );

      if ( !isTagInList ) {
        state = state.copyWith(
          tags: [...state.tags, tag]
        );
        return true;
      }

      state = state.copyWith(
        tags: state.tags.map(
          (element) => ( element.id == tag.id ) ? tag : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }

  }
  
  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );
    final tags = await tagsRepository
      .getTagsByPage( limit: state.limit, offset: state.offset );

    if ( tags.isEmpty ) {
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
      tags: [ ...state.tags, ...tags ]
    );
  } 
}


class TagsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Tag> tags;

  TagsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.tags = const []
  });

  TagsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Tag>? tags
  }) => TagsState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    tags: tags ?? this.tags
  );
}