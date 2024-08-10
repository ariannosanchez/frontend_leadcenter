import 'package:flutter/material.dart';


class CustomAppField extends StatelessWidget {

  final bool isTopField; // La idea es que tenga bordes redondeados arriba
  final bool isBottomField; // La idea es que tenga bordes redondeados abajo
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomAppField({
    super.key, 
    this.isTopField = false, 
    this.isBottomField = false, 
    this.label, 
    this.hint, 
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

    return Container(
      padding: const EdgeInsets.only(bottom: 0, top: 15),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines, 
        initialValue: initialValue,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
        ),
      ),
    );
  }
}