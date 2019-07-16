import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/DateInput.dart';

class AddExpiry extends StatelessWidget {

  const AddExpiry({
    @required this.setExpiry,
    @required this.focusNode,
    @required this.expiry,
  });

  final Function(DateTime) setExpiry;
  final FocusNode focusNode;
  final DateTime expiry;


  @override
  Widget build(BuildContext context) {
    return DateInput(
      focusNode: focusNode,
      validationFn: _validatePayment,
      initialValue: expiry,
      labelText: 'Expiry',
      hintText: 'Enter the bet Expiry',
      icon: AppIcons.futureBet,
    );
  }

String _validatePayment(DateTime value) {
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