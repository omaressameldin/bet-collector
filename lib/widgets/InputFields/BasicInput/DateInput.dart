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

    return DateTimePickerFormField(
    inputType: InputType.both,
    format: DateFormat("EE, MMM d, yyyy 'at' h:mma"),
    initialValue: initialValue,
    focusNode: focusNode,
    editable: false,
    resetIcon: null,
    style: inputStyle(),
    validator: validate,
    autofocus: true,
    decoration: decoration(),
  );
  }

  String validate(DateTime value);

}