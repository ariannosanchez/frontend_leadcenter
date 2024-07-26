import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  builder: (context) => _BottomSheetView(),
                );
              },
              icon: const Icon(Icons.filter_list_outlined))
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
  int? selectedStageId;
  int? selectedTagId;

  @override
  Widget build(BuildContext context) {
    final stageState = ref.watch(stagesProvider);
    final tagState = ref.watch(tagsProvider);

    return ListView(physics: const ClampingScrollPhysics(), children: [
      ExpansionTile(
        title: const Text('Estado'),
        subtitle: Text(selectedStageId != null ? stageState.stages.firstWhere((stage) => stage.id == selectedStageId).name : 'No seleccionado'),
        children: stageState.stages.map((stage) {
          return RadioListTile<int>(
            title: Text(stage.name),
            value: stage.id,
            groupValue: selectedStageId,
            onChanged: (value) {
              setState(() {
                selectedStageId = value;
                print( selectedStageId);
              });
            },
          );
        }).toList(),
      ),

      ExpansionTile(
        title: const Text('Etiqueta'),
        subtitle: Text(selectedTagId != null ? tagState.tags.firstWhere((tag) => tag.id == selectedTagId).name : 'No seleccionado'),
        children: tagState.tags.map((tag) {
          return RadioListTile<int>(
            title: Text(tag.name),
            value: tag.id,
            groupValue: selectedTagId,
            onChanged: (value) {
              setState(() {
                selectedTagId = value;
                print( selectedTagId);
              });
            },
          );
        }).toList(),
      )
    ]);
  }
}

enum Transportation { car, plane, boat, submarine }

class _bottomSheet extends State<_BottomSheetView> {
  bool isDeveloper = true;
  Transportation? selectedTransportation;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
            title: const Text('Developer Mode'),
            subtitle: const Text('Controles adicionales'),
            value: isDeveloper,
            onChanged: (value) => setState(() {
                  isDeveloper = !isDeveloper;
                })),
        ExpansionTile(
          title: const Text('Estado'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              title: const Text('Contactado'),
              value: Transportation.car,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('En seguimiento'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              title: const Text('Venta ganada'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              title: const Text('Sin venta'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('Estado'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              title: const Text('Contactado'),
              value: Transportation.car,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('En seguimiento'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              title: const Text('Venta ganada'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              title: const Text('Sin venta'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),
      ],
    );
  }
}

// class ModalBottomSheetContent extends ConsumerWidget {
//   const ModalBottomSheetContent({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stagesState = ref.watch(stagesProvider);
//     final tagsState = ref.watch(tagsProvider);

//     return const SizedBox(
//       height: 300,
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ExpansionTile(
//             title: Text('Etapa del Lead'),
//             subtitle: Text('Seleccionado'),
//           ),

//           ListView()
//         ],
//       ),
//     );
//   }
// }

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
