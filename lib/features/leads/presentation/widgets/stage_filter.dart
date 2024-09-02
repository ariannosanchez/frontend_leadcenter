import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';

class StageFilter extends ConsumerWidget {

  final int? selectedStage;
  final ValueChanged<int?> onStageSelected;

  const StageFilter({
    Key? key,
    required this.selectedStage,
    required this.onStageSelected,
  }): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;
    final stageState = ref.watch(stagesProvider);
    
    return ExpansionTile(
      title: Text(
        'Estado',
        style: textStyles.titleMedium,
      ),
      subtitle: Text(
        selectedStage != null
          ? stageState.stages
            .firstWhere((stage) => stage.id == selectedStage).name
          : 'Ninguno'
      ),
      children: stageState.stages.map((stage) {
        return RadioListTile<int>(
          title: Text(stage.name, style: textStyles.titleSmall),
          value: stage.id,
          groupValue: selectedStage,
          onChanged: onStageSelected,
        );
      }).toList(),
    );
  }
}