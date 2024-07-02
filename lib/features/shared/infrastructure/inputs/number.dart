import 'package:formz/formz.dart';

// Define input validation errors
enum NumberError { empty, value, format }

// Extend FormzInput and provide the input type and error type.
class Number extends FormzInput<int, NumberError> {


  // Call super.pure to represent an unmodified form input.
  const Number.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Number.dirty( int value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == NumberError.empty ) return 'El campo es requerido';
    if ( displayError == NumberError.value ) return 'Tiene que ser un número mayor o igual a cero';
    if ( displayError == NumberError.format ) return 'No tiene formato de número';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NumberError? validator(int value) {
    
    if ( value.toString().isEmpty || value.toString().trim().isEmpty ) return NumberError.empty;
    
    final isInteger = int.tryParse( value.toString()) ?? -1;
    if ( isInteger == -1 ) return NumberError.format;

    if ( value < 0 ) return NumberError.value;

    return null;
  }
}