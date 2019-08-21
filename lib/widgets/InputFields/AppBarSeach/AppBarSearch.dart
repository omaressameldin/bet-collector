import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class AppBarSearch extends Input {
  AppBarSearch({ @required this.onInputChange }) : super(
    focusNode: FocusNode(),
    labelText: '',
    hintText: 'Start typing to find bets',
    icon: null,
    inputSize: InputSize.small,
  );


  final Function onInputChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.start,
      minLines: 1,
      maxLines: 1,
      maxLength: 256,
      onChanged: validate,
      cursorColor: cursorColor(),
      style: inputStyle(),
      focusNode: focusNode,
      autofocus: true,
      textCapitalization: capitalization(),
      decoration: decoration(),
      buildCounter: buildCounter(),
    );
  }

  void validate(String value) {
    onInputChange();
  }
}