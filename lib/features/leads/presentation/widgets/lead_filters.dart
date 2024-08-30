import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';
class LeadsFiltersWidget extends ConsumerWidget {
  const LeadsFiltersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyles = Theme.of(context).textTheme;

    final stageState = ref.watch( stagesProvider );
    final tagState = ref.watch( tagsProvider );

    return Column(
      children: [
        // !Header
        Text(
          'Filtros',
          style: textStyles.titleMedium,
        ),
        const Divider(),

        //Body
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomDatePickerButton(), // Aquí se inserta el botón de selección de fecha
                ),
                ExpansionTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                  title: Text('Etiquetas'),
                  children: [
                    
                  ]
                ),

                ExpansionTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                  title: Text('Etapas'),
                  children: [

                  ],
                ),
              
              ],
            ),
          )
        ),

        const Divider(),
        // !Footer
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('Mostrar leads'),
              ),
              TextButton(onPressed: () {}, child: const Text('Limpiar filtros'))
            ],
          ),
        )
      ],
    );
  }
}

class CustomDatePickerButton extends StatelessWidget {
  const CustomDatePickerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom( // Borde del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        _selectDate(context);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined),
          SizedBox(width: 8),
          Text('Show date picker'),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selected != null) {
      // Maneja la fecha seleccionada
    }
  }
}
