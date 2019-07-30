import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/DateInput.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class AddExpiry extends DateInput {

  AddExpiry({
    @required this.setExpiry,
    @required FocusNode focusNode,
    @required DateTime initialValue,
    @required InputSize inputSize,
  }) : super(
    initialValue: initialValue,
    focusNode: focusNode,
    labelText: 'Expiry',
    hintText: 'Enter the bet Expiry',
    icon: AppIcons.futureBet,
    inputSize: inputSize
  );

  final Function(DateTime) setExpiry;

@override
String validate(DateTime value) {
    if (value == null) {
      return 'can\'t be empty';
    } else if(value.difference(DateTime.now()).inSeconds <= 0 ) {
      return 'has to be a future date';
    } else {
      setExpiry(value);
    }
    return null;
  }
}