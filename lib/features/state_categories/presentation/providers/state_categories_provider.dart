import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/state_categories/domain/domain.dart';
import 'package:lead_center/features/state_categories/presentation/providers/providers.dart';

final stateCategoriesProvider = StateNotifierProvider<StateCategoriesNotifier, StateCategoriesState>((ref){

  final stateCategoriesRepository = ref.watch( stateCategoriesRepositoryProvider );

  return StateCategoriesNotifier(
    stateCategoriesRepository: stateCategoriesRepository, 
  );
});


class StateCategoriesNotifier extends StateNotifier<StateCategoriesState> {

  final StateCategoriesRepository stateCategoriesRepository;

  StateCategoriesNotifier({
    required this.stateCategoriesRepository
  }): super( StateCategoriesState() ) {
    loadNextPage();
  }

  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );

    final stateCategories = await stateCategoriesRepository
      .getStateCategoriesByPage( limit: state.limit, offset: state.offset );

    if ( stateCategories.isEmpty ) {
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
      stateCategories: [ ...state.stateCategories, ...stateCategories ]
    );

  }
}

class StateCategoriesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<StateCategory> stateCategories;

  StateCategoriesState ({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.stateCategories = const[],
  });

  StateCategoriesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<StateCategory>? stateCategories,
  }) => StateCategoriesState (
    isLastPage : isLastPage ?? this.isLastPage,
    limit : limit ?? this.limit,
    offset : offset ?? this.offset,
    isLoading : isLoading ?? this.isLoading,
    stateCategories : stateCategories ?? this.stateCategories,
  );
}