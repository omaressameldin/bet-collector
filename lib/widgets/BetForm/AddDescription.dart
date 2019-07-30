import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/TextInput.dart';

class AddDescription extends TextInput {

  AddDescription({
    @required this.setDescription,
    @required FocusNode focusNode,
    @required String initialValue,
    @required InputSize inputSize,
  }): super(
    focusNode: focusNode,
    labelText: 'Description',
    hintText: 'Enter the bet description',
    icon: AppIcons.bet,
    initialValue: initialValue,
    inputSize: inputSize,
  );

  final Function(String) setDescription;

  @override
  String validate(String value) {
    const int minLength = 10;

    if (value.length < minLength) {
      return 'can\'t be empty (min $minLength chars)';
    } else {
      setDescription(value);
    }
    return null;
  }
}