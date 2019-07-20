import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

abstract class TextInput extends Input {
  const TextInput({
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

  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      maxLength: 256,
      initialValue: initialValue,
      validator: validate,
      cursorColor: cursorColor(),
      style: inputStyle(),
      focusNode: focusNode,
      autofocus: initialValue == null,
      textCapitalization: capitalization(),
      decoration: decoration(),
      buildCounter: buildCounter(),
    );
  }

  String validate(String value);
}