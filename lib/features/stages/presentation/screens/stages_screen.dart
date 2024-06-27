import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';

class StagesScreen extends StatelessWidget {
  const StagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Etapas'), 
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _StagesView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva etapa'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _StagesView extends ConsumerStatefulWidget {
  const _StagesView();

  @override
  _StagesViewState createState() => _StagesViewState();
}

class _StagesViewState extends ConsumerState {
  
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
    
    final stagesState = ref.watch( stagesProvider );

    return ListView.builder(
      controller: scrollController,
      itemCount: stagesState.stages.length,
      itemBuilder: (context, index) {
        final stage = stagesState.stages[index];
        return ListTile(
          title: Text( stage.name ),
          subtitle: Text( stage.stageCategory.name ),
        );
      },
    );

  }
}