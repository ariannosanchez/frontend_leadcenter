import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/shared/shared.dart';

//! 3- StateNotifierProvider - consume afuera
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  
  return LoginFormNotifier(
    loginUserCallback: loginUserCallback
  );
});

//! 1 - State de este provider
class LoginFormState {
  final bool isPositng;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPositng = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPositng,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPositng: isPositng ?? this.isPositng,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    // TODO: implement toString
    return '''
    LoginFormState:
    isPositng $isPositng
    isFormPosted $isFormPosted
    isValid $isValid
    email $email
    password $password
    ''';
  }
}

//! 2 - Como implementar un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }): super( LoginFormState() );
  
  onEmailChange( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.password ])
    );
  }

  onPasswordChange( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.email ])
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    
    if( !state.isValid ) return;

    state = state.copyWith( isPositng: true );

    await loginUserCallback( state.email.value, state.password.value );

    state = state.copyWith( isPositng: false );
  }

  _touchEveryField() {

    final email    = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([ email, password ])
    );

  }

}