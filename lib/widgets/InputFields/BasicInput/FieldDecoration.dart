import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class FieldDecoration extends InputDecoration {
  FieldDecoration({
    @required IconData icon,
    @required String hintText,
    @required String labelText,
    @required this.inputSize,
  }): super(
    counterStyle: TextStyles.inputCounterStyle(inputSize),
    fillColor: AppColors.white,
    errorStyle: TextStyles.errorStyle(inputSize),
    labelText: labelText,
    labelStyle: TextStyles.labelStyle(inputSize),
    border: InputBorder.none,
    hintText: hintText,
    hintStyle: TextStyles.hintStyle(inputSize),
    icon: Icon(icon, color: AppColors.primary),
  );

  final InputSize inputSize;
}