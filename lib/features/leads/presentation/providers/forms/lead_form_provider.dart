import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:lead_center/features/leads/domain/domain.dart';
import 'package:lead_center/features/leads/presentation/providers/providers.dart';
import 'package:lead_center/features/shared/infrastructure/inputs/inputs.dart';


final leadFormProvider = StateNotifierProvider.autoDispose.family<LeadFormNotifier, LeadFormState, Lead>(
  (ref, lead) {

    final createUpdateCallback = ref.watch( leadsProvider.notifier ).createOrUpdateLead;

    return LeadFormNotifier(
      lead: lead,
      onSubmitCallback: createUpdateCallback,
    );
  }
);

class LeadFormNotifier extends StateNotifier<LeadFormState> {

  final Future<bool> Function( Map<String, dynamic> leadLike )? onSubmitCallback;

  LeadFormNotifier({
    this.onSubmitCallback,
    required Lead lead,
  }): super (
    LeadFormState(
      id: lead.id,
      name: Name.dirty(lead.name),
      lastName: Name.dirty(lead.lastName),
      email: Email.dirty(lead.email),
      phone: Name.dirty(lead.phone),
      tag: Number.dirty(lead.tag.id),
      stage: Number.dirty(lead.stage.id),
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    if( onSubmitCallback == null ) return false;

    final leadLike = {
      'id': (state.id == 'new') ? null : state.id,
      'name': state.name.value,
      'lastName': state.lastName.value,
      'email': state.email.value,
      'phone': state.phone.value,
      'tagId': state.tag.value,
      'stageId': state.stage.value
    };

    try {
      return await onSubmitCallback!( leadLike );
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Name.dirty(state.lastName.value),
        Email.dirty(state.email.value),
        Name.dirty(state.phone.value),
        Number.dirty(state.tag.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      isFormValid: Formz.validate([
        name,
        Name.dirty(state.lastName.value),
        Email.dirty(state.email.value),
        Name.dirty(state.phone.value),
        Number.dirty(state.tag.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onLastNameChanged(String value) {
    final lastName = Name.dirty(value);
    state = state.copyWith(
      lastName: lastName,
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        lastName,
        Email.dirty(state.email.value),
        Name.dirty(state.phone.value),
        Number.dirty(state.tag.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Name.dirty(state.lastName.value),
        email,
        Name.dirty(state.phone.value),
        Number.dirty(state.tag.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onPhoneChanged(String value) {
    final phone = Name.dirty(value);
    state = state.copyWith(
      phone: phone,
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Name.dirty(state.lastName.value),
        Email.dirty(state.email.value),
        Number.dirty(state.tag.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onTagChanged(int value) {
    state = state.copyWith(
      tag: Number.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Name.dirty(state.lastName.value),
        Email.dirty(state.email.value),
        Name.dirty(state.phone.value),
        Number.dirty(state.stage.value),
      ]),
    );
  }

  void onStageChanged(int value) {
    state = state.copyWith(
      stage: Number.dirty(value),
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Name.dirty(state.lastName.value),
        Email.dirty(state.email.value),
        Name.dirty(state.phone.value),
        Number.dirty(state.tag.value),
      ]),
    );
  }
}


class LeadFormState {

  final bool isFormValid;
  final String? id;
  final Name name;
  final Name lastName;
  final Email email;
  final Name phone;
  final Number tag;
  final Number stage;

  LeadFormState({
    this.isFormValid = false,
    this.id,
    this.name = const Name.dirty(''),
    this.lastName = const Name.dirty(''),
    this.email = const Email.dirty(''),
    this.phone = const Name.dirty(''),
    this.tag = const Number.dirty(0),
    this.stage = const Number.dirty(0),
  });

  LeadFormState copyWith ({
    bool? isFormValid,
    String? id,
    Name? name,
    Name? lastName,
    Email? email,
    Name? phone,
    Number? tag,
    Number? stage,
  }) => LeadFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    tag: tag ?? this.tag,
    stage: stage ?? this.stage,
  );



}