import 'package:flutter/material.dart';
import 'package:lead_center/features/stages/domain/domain.dart';

class StageCard extends StatelessWidget {

  final Stage stage;

  const StageCard({
    super.key,
    required this.stage
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon( Icons.settings_applications_outlined, color: colors.primary ),
      trailing: Icon( Icons.arrow_forward_ios_rounded, color: colors.primary ),
      title: Text(stage.name),
      subtitle: Text(stage.stageCategory.name),
    );
  }
}