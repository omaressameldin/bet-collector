import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ChartInfo.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

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
    fontSize: 20.0
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

  static Function errorStyle = (InputSize inputSize) => TextStyle(
    fontSize: inputSize == InputSize.big ? 18.0 : 12.0,
    color: AppColors.danger,
    fontWeight: FontWeight.w400
  );

  static Function labelStyle = (InputSize inputSize) => TextStyle(
    fontSize: inputSize == InputSize.big ? 50.0 : 35.0,
    height: 0.75,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static Function hintStyle = (InputSize inputSize) => TextStyle(
    fontSize: inputSize == InputSize.big ? 18.0 : 12.0,
    color: AppColors.hintColor,
    fontWeight: FontWeight.bold
  );

  static Function inputStyle = (InputSize inputSize) => TextStyle(
    fontSize: inputSize == InputSize.big ? 18.0 : 12.0,
    color: AppColors.textInput,
    fontWeight: FontWeight.bold
  );

  static Function inputCounterStyle = (InputSize inputSize) => TextStyle(
    fontSize: inputSize == InputSize.big ? 15.0 : 12.0,
    color: AppColors.hintColor,
    fontWeight: FontWeight.bold
  );

  static Function chartLabelStyle = (ChartInfo info) => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(
      info.color.a,
      info.color.r,
      info.color.g,
      info.color.b,
    )
  );
}