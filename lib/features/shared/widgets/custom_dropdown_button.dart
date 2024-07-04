import 'package:flutter/material.dart';

class CustomDropdownButtonField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Function(T?)? onChanged;
  final Function(T?)? onSaved;
  final String? Function(T?)? validator;

  const CustomDropdownButtonField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    required this.items,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return DropdownButtonFormField<T>(
      value: items != null && items!.any((item) => item.value == value) ? value : null,
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
      style: const TextStyle( fontSize: 15, color: Colors.black54 ),
      validator: validator,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        isDense: true,
        filled: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
      ),
    );
  }
}
