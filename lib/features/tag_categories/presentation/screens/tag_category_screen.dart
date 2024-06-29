import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/shared/widgets/widgets.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';
class TagCategoryScreen extends ConsumerWidget {
  
  final int tagCategoryId;
  
  const TagCategoryScreen({ super.key, required this.tagCategoryId });

  void showSnackbar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Categoría Actualizada') )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tagCategoryState = ref.watch( tagCategoryProvider(tagCategoryId) );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text( tagCategoryId == 0 ? 'Nueva categoría' : 'Editar categoría' ),
        ),
        body: tagCategoryState.isLoading
          ? const FullScreenLoader()
          : _TagCategoryView( tagCategory: tagCategoryState.tagCategory! ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
      
            if ( tagCategoryState.tagCategory == null ) return;
      
            ref.read( 
              tagCategoryFormProvider(tagCategoryState.tagCategory!).notifier 
            ).onFormSubmit()
              .then((value) {
                if ( !value ) return;
                showSnackbar(context);
              });
            
          },
          child: const Icon( Icons.save_as_outlined ),
        ),
      ),
    );
  }
}

class _TagCategoryView extends ConsumerWidget {

  final TagCategory tagCategory;

  const _TagCategoryView({required this.tagCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tagCategoryForm = ref.watch( tagCategoryFormProvider(tagCategory) );

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
    
          const SizedBox( height: 10 ),
          Center(
            child: Text(
              tagCategoryForm.name.value,
              style: textStyles.titleSmall,
              textAlign: TextAlign.center, 
            )
          ),
          const SizedBox( height: 10 ), 
          _TagCategoryInformation( tagCategory: tagCategory ),
          
        ],
    );
  }
}


class _TagCategoryInformation extends ConsumerWidget {
  final TagCategory tagCategory;
  const _TagCategoryInformation({required this.tagCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final tagCategoryForm = ref.watch( tagCategoryFormProvider(tagCategory) );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomTagField( 
            label: 'Nombre',
            initialValue: tagCategoryForm.name.value,
            onChanged: ref.read( tagCategoryFormProvider(tagCategory).notifier).onNameChanged,
            errorMessage: tagCategoryForm.name.errorMessage,
          ),

          const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}
