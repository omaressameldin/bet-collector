import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class ActionButton {
  ActionButton({
    @required this.text,
    @required this.color,
    @required this.onPressed,
    @required this.isFlat,
    this.iconStyle,
  });

  final double iconSize = 15.0;
  final double horizontalPadding = 30.0;
  final double buttonRadius = 5.0;

  final String text;
  final Color color;
  final IconStyle iconStyle;
  final Function onPressed;
  final bool isFlat;

  ButtonTheme generateButton({Function callback}) {
    final Wrap buttonContent = Wrap(
      spacing: 2.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[Text(text, style: TextStyles.actionButton),
      ],
    );
    final Function pressedFn = () {
      onPressed();
      if (callback != null) {
        callback();
      }
    };
    final MaterialButton button = isFlat ?
      FlatButton(onPressed: pressedFn, child: buttonContent) :
      RaisedButton(onPressed: pressedFn, child: buttonContent);
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
      child: button,
    );
  }
}