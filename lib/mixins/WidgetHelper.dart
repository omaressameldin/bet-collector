import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';

mixin WidgetHelper {
  Container buildDividedContainer(bool isBig, Widget child, {bool isLast = false}) {
    final double rightPadding = isBig ?
      AppSizes.bigTitleDividerPadding : AppSizes.smallTitleDividerPadding;
    final double leftPadding = isBig ?
      AppSizes.zeroSpacing : AppSizes.smallTitleDividerPadding;

    return Container(
          padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
          decoration: BoxDecoration(
            border: isLast ? null : Border(right: BorderSide(
              width: 1.0 ,
              color: AppColors.secondary
            ))
          ),
          child: child,
      );
  }

  Widget horizontalDivider() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.widgetMargin,
        bottom: AppSizes.widgetMargin
      ),
      child: Container(
        height: 3.0,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(
            width: 3.0 ,
            color: AppColors.buttonText
          ))
        )
      )
    );
  }

  void showBottomModal(BuildContext context, Widget child) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => child,
    );
  }

  Future<void> showAlert(
    BuildContext context,
    String title,
    Widget child,
    List<ActionButton> actions,
  ) async {
    final Function dismissAlert = () => Navigator.of(context).pop();

    final List<ButtonTheme> actionButtons = actions.map((ActionButton button) =>
      button.generateButton(callback: dismissAlert)
    ).toList();

    actionButtons.add(ActionButton(
      shape: ButtonShape.flat,
      onPressed: dismissAlert,
      text: 'Discard',
      color: AppColors.transparent,
      iconStyle: IconStyle(icon: AppIcons.back, color: AppColors.buttonText)
    ).generateButton());

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: child,
          ),
          actions: actionButtons,
        );
      },
    );
  }

  void showSnackBar(String text, BuildContext context, {SnackBarAction action} ) {
    final Widget snackBar = SnackBar(
      content: Text(text),
      action: action,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
