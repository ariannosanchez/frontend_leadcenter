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
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text( lead.name[0], style: textStyles.bodyMedium ),
              ),
              title: Text( lead.phone, style: textStyles.titleSmall ),
              subtitle: Text( lead.name, style: textStyles.bodyMedium ),
              trailing: Text( HumanFormats.shortDate(lead.createdAt) ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
              ],
            ),
          ],
        ),
      ),
    );

    // return Center(
    //   child: Card(
    //     elevation: 5.0,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         ListTile(
    //           title: Text( lead.phone, style: textStyles.titleSmall, ),
    //           subtitle: Text( lead.name, style: textStyles.bodyMedium, ),
    //           leading: CircleAvatar(
    //             child: Text( lead.name[0], style: textStyles.bodyMedium, ),
    //           ),
    //           trailing: Text( lead.createdAt.toString(), style: textStyles.bodySmall, ),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             const SizedBox(width: 8),
    //             FilledButton.tonal(
    //               style: const ButtonStyle( visualDensity: VisualDensity.compact ),
    //               onPressed: () {},
    //               child: Text( lead.tag.name, style: textStyles.bodySmall, )
    //             ),
    //             const SizedBox(width: 8),
    //             FilledButton.tonal(
    //               style: const ButtonStyle( visualDensity: VisualDensity.compact ),
    //               onPressed: () {}, 
    //               child: Text( lead.stage.name, style: textStyles.bodySmall, )
    //             ),
    //             // Text( 'Arianno Sanchez', style: textStyles.bodySmall, ),
    //             const SizedBox(width: 10)
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    
    
  }
}