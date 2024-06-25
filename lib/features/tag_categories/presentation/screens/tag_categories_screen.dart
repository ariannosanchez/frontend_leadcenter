import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';

class TagCategoriesScreen extends StatelessWidget {
  const TagCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Categorias de etiqueta'),
      ),
      body: const _TagCategoriesView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva categoria'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _TagCategoriesView extends ConsumerStatefulWidget {
  const _TagCategoriesView();

  @override
  _TagCategoriesViewState createState() => _TagCategoriesViewState();
}


class _TagCategoriesViewState extends ConsumerState {

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
    
    final tagCategoriesState = ref.watch( tagCategoriesProvider );

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: tagCategoriesState.tagCategories.length,
      itemBuilder: (context, index) {
        final tagCategory = tagCategoriesState.tagCategories[index];
        return Text( tagCategory.name );
      }
    );

  }

  
}
