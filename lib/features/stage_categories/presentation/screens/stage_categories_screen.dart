import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stage_categories/presentation/providers/providers.dart';

class StageCategoriesScreen extends StatelessWidget {
  const StageCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Categorias de etapas'),
      ),
      body: const _StageCategoriesView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva categoria'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _StageCategoriesView extends ConsumerStatefulWidget {
  const _StageCategoriesView();

  @override
  _StageCategoriesViewState createState() => _StageCategoriesViewState();
}

class _StageCategoriesViewState extends ConsumerState {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final stageCategoriesState = ref.watch( stageCategoriesProvider );

    return ListView.builder(
      controller: scrollController,
      itemCount: stageCategoriesState.stageCategories.length,
      itemBuilder: (context, index) {
        final stageCategory = stageCategoriesState.stageCategories[index];
        return ListTile(
          title: Text( stageCategory.name ),
        );
      },
    );

  }

  
}

