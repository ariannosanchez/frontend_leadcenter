import 'package:flutter/material.dart';

class CustomAppDropdownButton<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Function(T?)? onChanged;
  final Function(T?)? onSaved;
  final String? Function(T?)? validator;

  const CustomAppDropdownButton({
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
    return Container(
      padding: const EdgeInsets.only(bottom: 0, top: 15),
      child: DropdownButtonFormField<T>(
        value: items != null && items!.any((item) => item.value == value) ? value : null,
        items: items,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
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
