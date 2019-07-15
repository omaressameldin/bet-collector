import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class FieldDecoration extends InputDecoration {
  FieldDecoration({
    @required IconData icon,
    @required String hintText,
    @required String labelText,
  }): super(
    counterStyle: TextStyles.inputCounterStyle,
    fillColor: AppColors.white,
    errorStyle: TextStyles.errorStyle,
    labelText: labelText,
    labelStyle: TextStyles.labelStyle,
    border: InputBorder.none,
    hintText: hintText,
    hintStyle: TextStyles.hintStyle,
    icon: Icon(icon, color: AppColors.primary),
  );
}