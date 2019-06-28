import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';

class TextStyles {
  static TextStyle actionButton = TextStyle(fontSize: 13.0, color: AppColors.buttonText);
  static TextStyle titleStyle = TextStyle(
    color: AppColors.cardTitle,
    fontWeight: FontWeight.bold
  );
  static TextStyle lightTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
    fontSize: 30.0
  );
  static TextStyle tooltipStyle = TextStyle(
    color: AppColors.cardText,
    fontWeight: FontWeight.bold
  );
  static TextStyle avatarText = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold
  );
}