import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/stage_categories/domain/domain.dart';
import 'package:lead_center/features/stage_categories/presentation/providers/providers.dart';

final stageCategoriesProvider = StateNotifierProvider<StageCategoriesNotifier, StageCategoriesState>((ref) {

  final stageCategoriesRepository = ref.watch( stageCategoriesRepositoryProvider );

  return StageCategoriesNotifier(
    stageCategoriesRepository: stageCategoriesRepository
  );
});

class StageCategoriesNotifier extends StateNotifier<StageCategoriesState> {

  final StageCategoriesRepository stageCategoriesRepository;

  StageCategoriesNotifier({
    required this.stageCategoriesRepository
  }): super( StageCategoriesState() ) {
    loadNextPage();
  }

  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );
    final stageCategories = await stageCategoriesRepository
      .getStageCategoriesByPage(limit: state.limit, offset: state.offset);

    if ( stageCategories.isEmpty ) {
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
      stageCategories: [ ...state.stageCategories, ...stageCategories ]
    );
  }
}

class StageCategoriesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<StageCategory> stageCategories;

  StageCategoriesState ({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.stageCategories = const []
  });

  StageCategoriesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<StageCategory>? stageCategories,
  }) => StageCategoriesState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    stageCategories: stageCategories ?? this.stageCategories
  );
}