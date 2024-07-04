import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomField({
    super.key, 
    this.label, 
    this.hint, 
    this.helperText,
    this.errorMessage, 
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.initialValue = '',
    this.onChanged, 
    this.onFieldSubmitted, 
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle( fontSize: 15, color: Colors.black54 ),
      maxLines: maxLines, 
      initialValue: initialValue,
      decoration: InputDecoration(
        floatingLabelBehavior: maxLines > 1 ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        isDense: true,
        filled: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        helperText: helperText,
        errorText: errorMessage,
        focusColor: colors.primary,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
      ),
    );
  }
}