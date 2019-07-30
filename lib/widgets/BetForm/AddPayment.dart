import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/TextInput.dart';
class AddPayment extends TextInput {

  AddPayment({
    @required this.setPayment,
    @required FocusNode focusNode,
    @required String initialValue,
    @required InputSize inputSize,
  }): super(
    focusNode: focusNode,
    labelText: 'Payment',
    hintText: 'Enter the bet payment',
    icon: AppIcons.bet,
    initialValue: initialValue,
    inputSize: inputSize,
  );

  final Function(String) setPayment;

@override
  String validate(String value) {
    const int minLength = 2;

    if (value.length < minLength) {
      return 'can\'t be empty (min $minLength chars)';
    } else {
      setPayment(value);
    }
    return null;
  }
}