import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';

class ActionButton {
  final double iconSize = 15.0;
  final double textSize = 13.0;
  final double horizontalPadding = 30.0;
  final double buttonRadius = 5.0;

  final String text;
  final Color color;
  final Color textColor;
  final IconStyle iconStyle;
  final Function onPressed;


  ActionButton({
    @required this.text,
    @required this.color,
    @required this.textColor,
    @required this.onPressed,
    this.iconStyle,
  });

  ButtonTheme generateButton() {
    Wrap buttonContent = Wrap(
      spacing: 2.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[Text(text, style: TextStyle(fontSize: textSize, color: textColor)),
      ],
    );
    if (iconStyle != null) {
      buttonContent.children.insert(
          0,
          Icon(iconStyle.icon, color: iconStyle.color, size: iconSize),
        );
    }
    return ButtonTheme(
      minWidth: 5.0,
      buttonColor: color,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
      child: RaisedButton(onPressed: onPressed, child: buttonContent),
    );
  }
}