import 'package:formz/formz.dart';

// Define input validation errors
enum NameErrror { empty }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameErrror> {

  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == NameErrror.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameErrror? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return NameErrror.empty;

    return null;
  }
}