import 'package:flutter/material.dart';

class CustomDropdownButtonField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final List<DropdownMenuItem<T>> items;
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

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
    );

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
      ),
    );
  }
}
