import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/presentation/widgets/widgets.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etiquetas'),
      ),
      body: const _TagsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nueva etiqueta'),
        icon: const Icon(Icons.add),
        onPressed: () {
          context.push('/tags/0');
        },
      ),
    );
  }
}

class _TagsView extends ConsumerStatefulWidget {
  const _TagsView();
  
  @override
  _TagsViewState createState() => _TagsViewState();
}


class _TagsViewState extends ConsumerState {

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
    
    final tagState = ref.watch( tagsProvider );

    return ListView.builder(
      controller: scrollController,
      itemCount: tagState.tags.length,
      itemBuilder: (context, index) {
        final tag = tagState.tags[index];
        return GestureDetector(
          onTap: () => context.push('/tags/${tag.id}'),
          child: TagCard(tag: tag),
        );
      }
    );
  }

}