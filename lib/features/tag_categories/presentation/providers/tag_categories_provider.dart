import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';

final tagCategoriesProvider = StateNotifierProvider<TagCategoriesNotifier,TagCategoriesState>((ref){

  final tagCategoriesRepository = ref.watch( tagCategoriesRepositoryProvider );

  return TagCategoriesNotifier(
    tagCategoriesRepository: tagCategoriesRepository,
  );
});

class TagCategoriesNotifier extends StateNotifier<TagCategoriesState> {
  
  final TagCategoriesRepository tagCategoriesRepository;

  TagCategoriesNotifier({
    required this.tagCategoriesRepository
  }): super( TagCategoriesState() ) {
    loadNextPage();
  }

  Future<bool> createOrUpdateTagCategory( Map<String, dynamic> tagCategoryLike ) async {
    
    try {
      final tagCategory = await tagCategoriesRepository.createUpdateTagCategory(tagCategoryLike); 
      final isTagCategoryInList = state.tagCategories.any((element) => element.id == tagCategory.id );
      
      if ( !isTagCategoryInList ){
        state = state.copyWith(
          tagCategories: [...state.tagCategories, tagCategory]
        );
        return true;
      }

      state = state.copyWith(
        tagCategories: state.tagCategories.map(
          (element) => ( element.id == tagCategory.id ) ? tagCategory : element, 
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
    final tagCategories = await tagCategoriesRepository
      .getTagCategoriesByPage(limit: state.limit, offset: state.offset);

    if ( tagCategories.isEmpty ) {
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
      tagCategories: [ ...state.tagCategories, ...tagCategories ]
    );

  }
}

class TagCategoriesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<TagCategory> tagCategories;

  TagCategoriesState ({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.tagCategories = const[],
  });

  TagCategoriesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<TagCategory>? tagCategories,
  }) => TagCategoriesState(
    isLastPage : isLastPage ?? this.isLastPage,
    limit : limit ?? this.limit,
    offset : offset ?? this.offset,
    isLoading : isLoading ?? this.isLoading,
    tagCategories : tagCategories ?? this.tagCategories,
  );
}