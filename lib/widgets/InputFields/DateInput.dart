import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

import 'FieldDecoration.dart';

class DateInput extends StatelessWidget {
  const DateInput({
    @required this.focusNode,
    @required this.validationFn,
    @required this.labelText,
    @required this.hintText,
    @required this.icon,
    @required this.initialValue,
  });

  final FocusNode focusNode;
  final Function validationFn;
  final String labelText;
  final String hintText;
  final IconData icon;
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
    style: TextStyles.inputStyle,
    validator: validationFn,
    autofocus: true,
    decoration: FieldDecoration(
      labelText: labelText,
      hintText: hintText,
      icon: icon,
    ),
  );
  }
}