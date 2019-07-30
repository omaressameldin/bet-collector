import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/FieldDecoration.dart';

enum InputSize {
  small, big
}

abstract class Input extends StatelessWidget {
  const Input({
    @required this.focusNode,
    @required this.labelText,
    @required this.hintText,
    @required this.icon,
    @required this.inputSize,
  });

  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final IconData icon;
  final InputSize inputSize;

  TextStyle inputStyle() => TextStyles.inputStyle(inputSize);

  Color cursorColor() => AppColors.textInput;

  InputDecoration decoration() {
    return FieldDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: icon,
        inputSize: inputSize,
      );
  }

  Function buildCounter() {
    switch(inputSize) {
      case InputSize.small: return _noWidgetRender;
      default: return null;
    }
  }

  Widget _noWidgetRender(BuildContext c, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) => null;

  TextCapitalization capitalization() => TextCapitalization.sentences;
}

