import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class ActionButton {
  ActionButton({
    @required this.text,
    @required this.color,
    @required this.onPressed,
    this.isFlat = false,
    this.isReversed = false,
    this.hasPadding = true,
    this.isBig = false,
    this.iconStyle,
  });

  final String text;
  final Color color;
  final IconStyle iconStyle;
  final Function onPressed;
  final bool isFlat;
  final bool isReversed;
  final bool isBig;
  final bool hasPadding;

  ButtonTheme generateButton({Function callback}) {
    final Wrap buttonContent = Wrap(
      spacing: AppSizes.iconSpacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[Text(
        text,
        textAlign: TextAlign.center,
        style: isBig ? TextStyles.bigActionButton : TextStyles.actionButton ),
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
          isReversed ? buttonContent.children.length : 0,
          Icon(
            iconStyle.icon,
            color: iconStyle.color,
            size: isBig ? AppSizes.mediumIconSize : AppSizes.smallIconSize,
            ),
        );
    }
    return ButtonTheme(
      minWidth: AppSizes.minButtonSize,
      buttonColor: color,
      padding: hasPadding ? EdgeInsets.symmetric(horizontal: AppSizes.bigButtonPadding) :
        const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.rectangleButtonRadius)
      ),
      child: button,
    );
  }
}