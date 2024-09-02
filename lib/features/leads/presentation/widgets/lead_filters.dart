import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/leads/presentation/widgets/widgets.dart';

class LeadsFiltersWidget extends ConsumerStatefulWidget {
  const LeadsFiltersWidget({Key? key}) : super(key: key);

  @override
  _LeadsFiltersWidgetState createState() => _LeadsFiltersWidgetState();
}

class _LeadsFiltersWidgetState extends ConsumerState<LeadsFiltersWidget> {
  String? _startDate;
  String? _endDate;
  int? _selectedStage;
  int? _selectedTag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final leadsState = ref.read(leadsProvider);
    _selectedStage = leadsState.stageId;
    _selectedTag = leadsState.tagId;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Filtros',
          style: textStyles.titleMedium,
        ),
        const Divider(),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomDatePickerButton(),
                ),
                StageFilter(
                  selectedStage: _selectedStage, 
                  onStageSelected: (value) {
                    setState(() {
                      _selectedStage = value;
                    });
                  }
                ),
                TagFilter(
                  selectedTag: _selectedTag, 
                  onTagSelected: (value) {
                    setState(() {
                      _selectedTag = value;
                    });
                  }
                )
              ],
            ),
          ),
        ),

        const Divider(),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () {
                  // Acción para mostrar leads con filtros
                  ref.read(leadsProvider.notifier).applyFilters(
                    stageId: _selectedStage,
                    tagId: _selectedTag,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Mostrar leads'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedStage = null;
                    _selectedTag = null;
                  });
                  ref.read(leadsProvider.notifier).clearFilters();
                  Navigator.pop(context);
                },
                child: const Text('Limpiar filtros'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
