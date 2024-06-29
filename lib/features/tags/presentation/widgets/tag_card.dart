import 'package:flutter/material.dart';
import 'package:lead_center/features/tags/domain/domain.dart';

class TagCard extends StatelessWidget {
  
  final Tag tag;

  const TagCard({
    super.key,
    required this.tag
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon( Icons.label_outline, color: colors.primary ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary ),
      title: Text(tag.name),
      subtitle: Text(tag.tagCategory.name),
    );
  }
}