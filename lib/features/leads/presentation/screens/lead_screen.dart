import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/infrastructure/services/whatsapp_redirect.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/stages/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class LeadScreen extends ConsumerWidget {
  final String leadId;
  final WhatsappRedirect _whatsappRedirect = WhatsappRedirect();

  LeadScreen({ super.key, required this.leadId });

  void showSnackBar( BuildContext context ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lead Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final leadState = ref.watch(leadProvider(leadId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Lead'),
          actions: [
            IconButton(
              onPressed: () {
                _whatsappRedirect.openWhatsapp(
                  phone: "+${leadState.lead!.phone}",
                  text: 'Hola'
                );
              },
              icon: const Icon(Icons.perm_phone_msg_outlined)
            )
          ],
        ),
        body: leadState.isLoading
            ? const FullScreenLoader()
            : _LeadView(lead: leadState.lead!),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
            if ( leadState.lead == null ) return;

            ref.read(
              leadFormProvider(leadState.lead!).notifier
            ).onFormSubmit()
              .then((value){
                if ( !value ) return;
                showSnackBar(context);
              });
          },
          child: const Icon(Icons.save_as_outlined),
        ),
      ),
    );
  }
}

class _LeadView extends ConsumerWidget {
  final Lead lead;

  const _LeadView({required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final leadForm = ref.watch( leadFormProvider(lead) );
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

        SizedBox(
          height: 150,
          width: 600,
          child: CircleAvatar(
            child: Text( lead.name[0], style: textStyles.displayLarge ),
          ),
        ),
        const SizedBox( height: 10 ),
        Center(
          child: Text(
            '${leadForm.name.value} ${leadForm.lastName.value}', 
            style: textStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox( height: 10 ),
        _LeadInformation( lead : lead ),
      ],
    );
  }
}

class _LeadInformation extends ConsumerWidget {
  final Lead lead;
  const _LeadInformation({required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final leadForm = ref.watch( leadFormProvider(lead) );
    final stages = ref.watch( stagesProvider );
    final tags = ref.watch( tagsProvider );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppField(
            label: 'Nombre',
            initialValue: leadForm.name.value,
            onChanged: ref.read( leadFormProvider(lead).notifier).onNameChanged,
            errorMessage: leadForm.name.errorMessage,
          ),
          CustomAppField(
            label: 'Apellidos',
            initialValue: leadForm.lastName.value,
            onChanged: ref.read( leadFormProvider(lead).notifier).onLastNameChanged,
            errorMessage: leadForm.lastName.errorMessage,
          ),
          CustomAppField(
            label: 'Email',
            initialValue: leadForm.email.value,
            onChanged: ref.read( leadFormProvider(lead).notifier).onEmailChanged,
            errorMessage: leadForm.email.errorMessage,
          ),
          CustomAppField(
            label: 'Teléfono',
            initialValue: leadForm.phone.value,
            keyboardType: const TextInputType.numberWithOptions(),
            onChanged: ref.read( leadFormProvider(lead).notifier).onPhoneChanged,
            errorMessage: leadForm.phone.errorMessage,
          ),
          CustomAppDropdownButton(
            label: 'Etiqueta',
            value: leadForm.tag.value,
            items: tags.tags.map(
              (tag) => DropdownMenuItem(
                value: tag.id,
                child: Text(tag.name),
              )).toList(),
            onChanged: ( value ) =>
              ref.read( leadFormProvider(lead).notifier).onTagChanged( value ?? 0),
            errorMessage: leadForm.tag.errorMessage,
          ),
          CustomAppDropdownButton(
            label: 'Etapa',
            value: leadForm.stage.value,
            items: stages.stages.map(
              (stage) => DropdownMenuItem(
                value: stage.id,
                child: Text(stage.name),
              )).toList(),
            onChanged: ( value ) =>
              ref.read( leadFormProvider(lead).notifier).onStageChanged( value ?? 0),
            errorMessage: leadForm.stage.errorMessage,
          ),
          const CustomAppField(
            maxLines: 4,
            keyboardType: TextInputType.multiline,
          )
        ],
      ),
    );
  }
}

