import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

enum ButtonShape {
  flat,
  flatBordered,
  raised,
}

class ActionButton {
  ActionButton({
    @required this.text,
    @required this.color,
    @required this.onPressed,
    this.shape = ButtonShape.raised,
    this.isReversed = false,
    this.hasPadding = true,
    this.isBig = false,
    this.iconStyle,
  });

  final String text;
  final Color color;
  final IconStyle iconStyle;
  final Function onPressed;
  final ButtonShape shape;
  final bool isReversed;
  final bool isBig;
  final bool hasPadding;

  ButtonTheme generateButton({Function callback}) {

    return ButtonTheme(
      minWidth: AppSizes.minButtonSize,
      buttonColor: color,
      padding: hasPadding ? EdgeInsets.symmetric(horizontal: AppSizes.bigButtonPadding) :
        const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.rectangleButtonRadius)
      ),
      child: _renderButtonShape(callback),
    );
  }

  Widget _renderButtonContent() {
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

    return buttonContent;
  }

  MaterialButton _renderButtonShape(Function callback) {
    final Function pressedFn = () {
      onPressed();
      if (callback != null) {
        callback();
      }
    };
    final Widget content = _renderButtonContent();

    switch(shape) {
      case ButtonShape.flat:
        return FlatButton(onPressed: pressedFn, child: content);
      case ButtonShape.flatBordered:
        return OutlineButton(
          onPressed: pressedFn,
          child: content,
          borderSide: BorderSide(color: color),
        );
      default:
        return RaisedButton(onPressed: pressedFn, child: content);
    }
  }
}