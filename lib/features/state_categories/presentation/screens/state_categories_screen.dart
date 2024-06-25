import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/state_categories/presentation/providers/state_categories_provider.dart';

class StateCategoriesScreen extends StatelessWidget {
  const StateCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Categorias de estado'),
      ),
      body: const _StateCategoriesView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva categoria'),
        icon: const Icon(Icons.add),
        onPressed: () {}, 
      ),
    );
  }
}

class _StateCategoriesView extends ConsumerStatefulWidget {
  const _StateCategoriesView();
  
  @override
  _StateCategoriesViewState createState() => _StateCategoriesViewState(); 
}


class _StateCategoriesViewState extends ConsumerState {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    scrollController.addListener((){
      if ( (scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent ){
        ref.read(stateCategoriesProvider.notifier).loadNextPage();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final stateCategoriesState = ref.watch( stateCategoriesProvider );

    print('Number of state categories: ${stateCategoriesState.stateCategories.length}');

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: stateCategoriesState.stateCategories.length,
      itemBuilder: (context, index) {
        final stateCategory = stateCategoriesState.stateCategories[index];
        return Text( stateCategory.name );
      },
    );

  }
}