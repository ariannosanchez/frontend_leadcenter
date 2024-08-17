import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/leads/presentation/widgets/widgets.dart';
import 'package:lead_center/features/shared/shared.dart';

class LeadsStageScreen extends ConsumerWidget {
  final int stageId;
  const LeadsStageScreen({super.key, required this.stageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final leadsStageState = ref.watch(leadsStageProvider(stageId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leads por Etapa'),
        ),
        body: leadsStageState.isLoading
            ? const FullScreenLoader()
            : _LeadsStageView(leads: leadsStageState.leads)
      ),
      
    );
  }
}

class _LeadsStageView extends StatelessWidget {

  final List<Lead> leads;

  const _LeadsStageView({
    super.key,
    required this.leads,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:  const EdgeInsets.all(5),
      itemCount: leads.length,
      itemBuilder: (context, index) {
        final lead = leads[index];
        return GestureDetector(
          onTap: () => context.push('/lead/${lead.id}'),
          child: LeadsCard(lead: lead),
        );
      },
    );
  }
}
