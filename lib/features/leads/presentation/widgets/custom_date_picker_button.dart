import 'package:flutter/material.dart';

class CustomDatePickerButton extends StatelessWidget {
  const CustomDatePickerButton({
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
      onPressed: () {
        _selectDate(context);
      }, 
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined),
          SizedBox(width: 8),
          Text('Seleccionar rango de fechas'),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if ( selected != null ) {

    }
  }
}