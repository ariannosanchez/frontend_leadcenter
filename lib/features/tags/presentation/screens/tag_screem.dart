import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class TagScreen extends ConsumerWidget {

  final int tagId;

  const TagScreen({super.key, required this.tagId});

  void showSnackbar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Etiqueta actualizada'))
    );
  } 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tagState = ref.watch( tagProvider(tagId) );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar etiqueta'),
        ),
      
        body: tagState.isLoading
          ? const FullScreenLoader()
          : _TagView( tag: tagState.tag! ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
      
            if ( tagState.tag == null ) return;
            
            ref.read(
              tagFormProvider(tagState.tag!).notifier
            ).onFormSubmit()
              .then((value) {
                if ( !value ) return;
                showSnackbar(context); 
              });
            
          },
          child: const Icon((Icons.save_as_outlined)),  
        ),
      ),
    );
  }
}

class _TagView extends ConsumerWidget {

  final Tag tag;

  const _TagView({required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tagForm = ref.watch( tagFormProvider(tag) );

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
          const SizedBox( height: 10 ),
          Center(
            child: Text(
              tagForm.name.value,
              style: textStyles.titleSmall,
              textAlign: TextAlign.center, 
            )
          ),
          const SizedBox( height: 10 ),
          _TagInformation( tag: tag ),
          
        ],
    );
  }
}

class _TagInformation extends ConsumerWidget {
  final Tag tag;
  const _TagInformation({required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final tagForm = ref.watch( tagFormProvider(tag) );

    final tagCategories = ref.watch( tagCategoriesProvider );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          CustomAppField( 
            label: 'Nombre',
            initialValue: tagForm.name.value,
            onChanged: ref.read( tagFormProvider(tag).notifier).onNameChanged,
            errorMessage: tagForm.name.errorMessage,
          ),

          CustomAppDropdownButton(
            label: 'Categoría',
            value: tagForm.tagCategory.value,
            items: tagCategories.tagCategories.map(
              (tagCategory) => DropdownMenuItem(
                value: tagCategory.id,
                child: Text(tagCategory.name, style: const TextStyle( fontSize: 15, fontWeight: FontWeight.normal ) ),
              )).toList(),
            onChanged: ( value ) =>
              ref.read( tagFormProvider(tag).notifier).onTagCategoryChanged(value ?? 0),
            errorMessage: tagForm.tagCategory.errorMessage,
          ),

        ],
      ),
    );
  }
}