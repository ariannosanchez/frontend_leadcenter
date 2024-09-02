import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class TagFilter extends ConsumerWidget {
  final int? selectedTag;
  final ValueChanged<int?> onTagSelected;
  
  const TagFilter({
    Key? key,
    required this.selectedTag,
    required this.onTagSelected,
  }): super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;
    final tagState = ref.watch(tagsProvider);
    
    return ExpansionTile(
      title: Text(
        'Etiqueta',
        style: textStyles.titleMedium,
      ),
      subtitle: Text(
        selectedTag != null
          ? tagState.tags
            .firstWhere((tag) => tag.id == selectedTag).name
          : 'Ninguna'
      ),
      children: tagState.tags.map((tag){
        return RadioListTile<int>(
          title: Text(tag.name, style: textStyles.titleSmall),
          value: tag.id,
          groupValue: selectedTag,
          onChanged: onTagSelected,
        );
      }).toList(),
    );
  }
}