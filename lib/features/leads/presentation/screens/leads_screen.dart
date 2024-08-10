import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/features/leads/presentation/delegates/search_lead_delegate.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/leads/presentation/widgets/widgets.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class LeadsScreen extends ConsumerWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: Text('Leads', style: titleStyle),
        actions: [
          IconButton(
              onPressed: () {
                final leadRepository = ref.read(leadsRepositoryProvider);

                showSearch(
                    context: context,
                    delegate: SearchLeadDelegate(
                        searchLeads: leadRepository.searchLeads));
              },
              icon: const Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) => const _BottomSheetView(),
                );
              },
              icon: const Icon(Icons.tune_outlined))
        ],
      ),
      body: const _LeadsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo lead'),
        icon: const Icon(Icons.add),
        onPressed: () {
          context.push('/lead/new');
        },
      ),
    );
  }
}

class _BottomSheetView extends ConsumerStatefulWidget {
  const _BottomSheetView();

  @override
  _BottomSheetViewState createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends ConsumerState {

  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    final stageState = ref.watch(stagesProvider);
    final tagState = ref.watch(tagsProvider);
    final selectedStageId = ref.watch(selectedStageProvider);
    final selectedTagId = ref.watch(selectedTagProvider);

    final textStyles = Theme.of(context).textTheme;

    final DateTime _firstDate = DateTime(DateTime.now().year - 2);
    final DateTime _lastDate = DateTime(DateTime.now().year + 1);

    return ListView(physics: const ClampingScrollPhysics(), children: [
      Text('Filtros',
          style: textStyles.titleMedium, textAlign: TextAlign.center),
      TextButton( 
        onPressed: () async {
          
          final DateTimeRange? picked = await showDateRangePicker(
            context: context,
            firstDate: _firstDate,
            lastDate: _lastDate,
          );

          if ( picked != null ) {
            setState(() {
              selectedDateRange = picked; 
            });
          }
        },
        child: const Text('Show date picker')
      ),
      ExpansionTile(
        title: Text(
          'Estado',
          style: textStyles.titleMedium,
        ),
        subtitle: Text(
            selectedStageId != null
                ? stageState.stages
                    .firstWhere((stage) => stage.id == selectedStageId)
                    .name
                : 'Ninguno',
            style: textStyles.bodySmall),
        children: stageState.stages.map((stage) {
          return RadioListTile<int>(
            title: Text(stage.name, style: textStyles.titleSmall),
            controlAffinity: ListTileControlAffinity.trailing,
            value: stage.id,
            groupValue: selectedStageId,
            onChanged: (value) {
              ref.read(selectedStageProvider.notifier).state = value;
            },
          );
        }).toList(),
      ),
      ExpansionTile(
        dense: true,
        title: Text('Etiqueta', style: textStyles.titleMedium),
        subtitle: Text(
            selectedTagId != null
                ? tagState.tags
                    .firstWhere((tag) => tag.id == selectedTagId)
                    .name
                : 'Ninguno',
            style: textStyles.bodySmall),
        children: tagState.tags.map((tag) {
          return RadioListTile<int>(
            title: Text(tag.name, style: textStyles.titleSmall),
            controlAffinity: ListTileControlAffinity.trailing,
            value: tag.id,
            groupValue: selectedTagId,
            onChanged: (value) {
              ref.read(selectedTagProvider.notifier).state = value;
            },
          );
        }).toList(),
      ),
      FilledButton(
        onPressed: () {
          ref.read(leadsProvider.notifier).setFilters(
            stageId: selectedStageId,
            tagId: selectedTagId,
            startDate: selectedDateRange?.start.toIso8601String(),
            endDate: selectedDateRange?.end.toIso8601String()
          );
          print(selectedDateRange);
          Navigator.of(context).pop();
        },
        child: const Text('Ver leads'),
      ),
      FilledButton(
        onPressed: () {
          ref.read(selectedStageProvider.notifier).state = null;
          ref.read(selectedTagProvider.notifier).state = null;
          ref.read(leadsProvider.notifier).clearFilters();
          Navigator.of(context).pop();
        },
        child: const Text('Restablecer'),
      )
    ]);
  }
}

class _LeadsView extends ConsumerStatefulWidget {
  const _LeadsView();

  @override
  _LeadsViewState createState() => _LeadsViewState();
}

class _LeadsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(leadsProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leadsState = ref.watch(leadsProvider);

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(5),
      itemCount: leadsState.leads.length,
      itemBuilder: (context, index) {
        final lead = leadsState.leads[index];
        return GestureDetector(
            onTap: () => context.push('/lead/${lead.id}'),
            child: LeadsCard(lead: lead));
      },
    );
  }
}
