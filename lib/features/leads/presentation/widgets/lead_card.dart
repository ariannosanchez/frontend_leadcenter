import 'package:flutter/material.dart';
import 'package:lead_center/features/leads/domain/domain.dart';

class LeadsCard extends StatelessWidget {

  final Lead lead;

  const LeadsCard ({
    super.key,
    required this.lead
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Center(
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text( lead.phone, style: textStyles.titleSmall, ),
              subtitle: Text( lead.name, style: textStyles.bodyMedium, ),
              leading: CircleAvatar(
                child: Text( lead.name[0], style: textStyles.bodyMedium, ),
              ),
              trailing: Text( lead.createdAt.toString(), style: textStyles.bodySmall, ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 8),
                FilledButton.tonal(
                  style: const ButtonStyle( visualDensity: VisualDensity.compact ),
                  onPressed: () {},
                  child: Text( lead.tag.name, style: textStyles.bodySmall, )
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  style: const ButtonStyle( visualDensity: VisualDensity.compact ),
                  onPressed: () {}, 
                  child: Text( lead.stage.name, style: textStyles.bodySmall, )
                ),
                const Spacer(),
                // Text( 'Arianno Sanchez', style: textStyles.bodySmall, ),
                const SizedBox(width: 10)
              ],
            ),
          ],
        ),
      ),
    );

    
    
  }
}