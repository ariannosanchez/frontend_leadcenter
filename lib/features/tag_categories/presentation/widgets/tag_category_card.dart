import 'package:flutter/material.dart';
import 'package:lead_center/features/tag_categories/domain/domain.dart';

class TagCategoryCard extends StatelessWidget {

  final TagCategory tagCategory;

  const TagCategoryCard({
    super.key,
    required this.tagCategory
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon( Icons.tag, color: colors.primary ),
      trailing: Icon( Icons.arrow_forward_ios_rounded, color: colors.primary ),
      title: Text(tagCategory.name),
    );
  }
}