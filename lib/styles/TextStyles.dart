import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';

class TextStyles {
  static TextStyle actionButton = TextStyle(fontSize: 13.0, color: AppColors.buttonText);
  static TextStyle bigActionButton = TextStyle(
    fontSize: 20.0,
    color: AppColors.buttonText,
  );

  static TextStyle titleStyle = TextStyle(
    color: AppColors.cardTitle,
    fontWeight: FontWeight.bold
  );
  static TextStyle lightTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
    fontSize: 30.0
  );
  static TextStyle detailsStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.cardText,
    fontSize: 15.0
  );
  static TextStyle tooltipStyle = TextStyle(
    color: AppColors.cardText,
    fontWeight: FontWeight.bold
  );
  static TextStyle avatarText = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold
  );
  static TextStyle chipStyle = TextStyle(
    fontSize: 12.0,
    color: AppColors.white,
    fontWeight: FontWeight.bold
  );

  static TextStyle errorStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.danger,
    fontWeight: FontWeight.w400
  );

  static TextStyle labelStyle = TextStyle(
    fontSize: 50.0,
    height: 0.75,
    color: AppColors.primary,
    fontWeight: FontWeight.bold
  );

  static TextStyle hintStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.hintColor,
    fontWeight: FontWeight.bold
  );

  static TextStyle inputStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.textInput,
    fontWeight: FontWeight.bold
  );

  static TextStyle inputCounterStyle = TextStyle(
    fontSize: 15.0,
    color: AppColors.hintColor,
    fontWeight: FontWeight.bold
  );
}