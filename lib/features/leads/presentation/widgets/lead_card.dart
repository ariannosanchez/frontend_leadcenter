import 'package:flutter/material.dart';
import 'package:lead_center/config/helpers/human_formats.dart';
import 'package:lead_center/features/leads/domain/domain.dart';

class LeadsCard extends StatelessWidget {

  final Lead lead;

  const LeadsCard ({
    super.key,
    required this.lead
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Card(
      color: colors.surfaceContainerHighest,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(lead.name[0], style: textStyles.bodyMedium),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lead.name, style: textStyles.titleSmall),
                      Text(lead.phone, style: textStyles.bodyMedium),
                    ],
                  ),
                ),
                Text(
                  HumanFormats.shortDate(lead.createdAt),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Chip(
                  label: Text(
                    lead.tag.name,
                    style: textStyles.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    lead.stage.name,
                    style: textStyles.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Alinea el nombre del usuario a la derecha
              children: [
                Text(
                  'Asignado a: ${lead.user?.fullName ?? 'Unassigned'}',
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}