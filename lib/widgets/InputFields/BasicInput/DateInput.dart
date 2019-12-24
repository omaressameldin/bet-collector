import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';


abstract class DateInput extends Input {
  const DateInput({
    @required this.initialValue,
    @required FocusNode focusNode,
    @required String labelText,
    @required String hintText,
    @required IconData icon,
    @required InputSize inputSize,
  }) : super(
    focusNode: focusNode,
    labelText: labelText,
    hintText: hintText,
    icon: icon,
    inputSize: inputSize,
  );

  final DateTime initialValue;
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: DateFormat("EE, MMM d, yyyy 'at' h:mma"),
      style: inputStyle(),
      decoration: decoration(),
      readOnly: true,
      validator: validate,
      resetIcon: null,
      initialValue: initialValue ?? DateTime.now(),
      onShowPicker: (BuildContext context, DateTime currentValue) async {
        final DateTime date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100)
        );
        if (date != null) {
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime:
                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      }
    );
  }

  String validate(DateTime value);

}