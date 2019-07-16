import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/TextInput.dart';

class AddPayment extends StatelessWidget {

  const AddPayment({
    @required this.setPayment,
    @required this.focusNode,
    @required this.payment,
  });

  final Function(String) setPayment;
  final FocusNode focusNode;
  final String payment;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      focusNode: focusNode,
      validationFn: _validatePayment,
      labelText: 'Payment',
      hintText: 'Enter the bet Payment',
      initialValue: payment,
      icon: AppIcons.payment,
    );
  }

String _validatePayment(String value) {
  const int minLength = 20;

    if (value.length < minLength) {
      return 'can\'t be empty (min $minLength chars)';
    } else {
      setPayment(value);
    }
    return null;
  }
}