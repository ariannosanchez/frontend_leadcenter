import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stage_categories/presentation/providers/providers.dart';
import 'package:lead_center/features/stages/domain/domain.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';

class StageScreen extends ConsumerWidget {

  final int stageId;

  const StageScreen({super.key, required this.stageId});

  void showSnackBar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Etapa actualizada'))
    );
  }  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final stageState = ref.watch( stageProvider(stageId) );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar etapa'),
        ),

        body: stageState.isLoading
          ? const FullScreenLoader()
          : _StageView( stage: stageState.stage! ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            if ( stageState.stage == null ) return;

            ref.read(
              stageFormProvider(stageState.stage!).notifier
            ).onFormSubmit()
              .then((value) {
                if ( !value ) return;
                showSnackBar(context);
              });

          },
          child: const Icon((Icons.save_as_outlined)),
        ),
      ),
    );
  }
}

class _StageView extends ConsumerWidget {

  final Stage stage;

  const _StageView({required this.stage});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return ListView(
      children: [
        _StageInformation( stage : stage ),
      ],
    );
  }
}

class _StageInformation extends ConsumerWidget {
  final Stage stage;
  const _StageInformation({required this.stage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stageForm = ref.watch( stageFormProvider(stage) );
    final stageCategories = ref.watch( stageCategoriesProvider );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppField(
            label: 'Nombre',
            initialValue: stageForm.name.value,
            onChanged: ref.read( stageFormProvider(stage).notifier).onNameChanged,
            errorMessage: stageForm.name.errorMessage,
          ),
          
          CustomAppDropdownButton(
            label: 'Categoría',
            value: stageForm.stageCategory.value,
            items: stageCategories.stageCategories.map(
              (stageCategory) => DropdownMenuItem(
                value: stageCategory.id,
                child: Text(stageCategory.name),
              )).toList(),
            onChanged: ( value ) =>
              ref.read( stageFormProvider(stage).notifier).onStageCategoyChanged( value ?? 0),
            errorMessage: stageForm.stageCategory.errorMessage,
          ),
        ],
      ),
    );
  }
}