import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/shared/shared.dart';

class LeadScreen extends ConsumerWidget {
  final String leadId;

  const LeadScreen({ super.key, required this.leadId });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadState = ref.watch(leadProvider(leadId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Lead'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline_rounded)
          )
        ],
      ),
      body: leadState.isLoading
          ? const FullScreenLoader()
          : _LeadView(lead: leadState.lead!),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}

class _LeadView extends StatelessWidget {
  final Lead lead;

  const _LeadView({required this.lead});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        _LeadInformation(lead: lead),
      ],
    );
  }
}

class _LeadInformation extends ConsumerWidget {
  final Lead lead;
  const _LeadInformation({required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Configuración (1 de 3)'),
          const SizedBox(height: 15),
          CustomLeadField(
            isTopField: true,
            label: 'Elige un estado',
            initialValue: lead.stage.name,
          ),
          CustomLeadField(
            isTopField: true,
            label: 'Elige el responsable',
            initialValue: lead.user.fullName,
          ),
          const SizedBox(height: 5),
          
          const Text('Datos de contacto (2 de 3)'),
          const SizedBox(height: 15),

          CustomLeadField(
            isTopField: true,
            label: 'Nombre(s)',
            initialValue: lead.name,
          ),
          CustomLeadField(
            isTopField: true,
            label: 'Apellido(s)',
            initialValue: lead.lastName,
          ),
          CustomLeadField(
            isTopField: true,
            label: 'Email',
            initialValue: lead.email,
          ),
          CustomLeadField(
            isTopField: true,
            label: 'Teléfono',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: lead.phone,
          ),

          const SizedBox(height: 15),
          const Text('Extras'),

        ],
      ),
    );
  }
}

