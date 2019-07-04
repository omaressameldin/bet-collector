import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/InputFields/TextInput.dart';

class AddDescription extends StatelessWidget {

  const AddDescription({@required this.setDescription, @required this.focusNode});

  final Function(String) setDescription;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      focusNode: focusNode,
      validationFn: _validateDescription,
      labelText: 'Description',
      hintText: 'Enter the bet description',
      icon: AppIcons.bet,
    );
  }

String _validateDescription(String value) {
  const int minLength = 20;

    if (value.length < minLength) {
      return 'can\'t be empty (min $minLength chars)';
    } else {
      setDescription(value);
    }
    return null;
  }
}