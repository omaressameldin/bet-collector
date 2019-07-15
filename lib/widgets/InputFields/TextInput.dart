import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/InputFields/FieldDecoration.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    @required this.focusNode,
    @required this.validationFn,
    @required this.labelText,
    @required this.hintText,
    @required this.icon
  });

  final FocusNode focusNode;
  final Function validationFn;
  final String labelText;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      maxLength: 256,
      validator: validationFn,
      cursorColor: AppColors.textInput,
      style: TextStyles.inputStyle,
      focusNode: focusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: FieldDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: icon,
      ),
    );
  }
}