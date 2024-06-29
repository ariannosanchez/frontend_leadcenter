import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class TagScreen extends ConsumerWidget {

  final int tagId;

  const TagScreen({super.key, required this.tagId});

  void showSnackBar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Etiqueta actualizada') )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tagState = ref.watch( tagProvider(tagId) );

    return Scaffold(
      appBar: AppBar(
        title: Text( tagId == 0 ? 'Nueva etiqueta' : 'Editar etiqueta' ),
      ),
      body: tagState.isLoading
        ? const FullScreenLoader()
        : const _TagView( ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}
      ),
    );
  }
}

class _TagView extends StatelessWidget {
  const _TagView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final textStyles = Theme.of(context).textTheme;
    
    return ListView(
      children: [
        const SizedBox( height: 10 ),
        Center(
          child: Text(
            'Etiqueta',
            style: textStyles.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox( height: 10 ),
      ],
    );
  }
}