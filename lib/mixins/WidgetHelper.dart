import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
mixin WidgetHelper {
  Container buildDividedContainer(bool isBig, Widget child, {bool isLast = false}) {
    final double rightPadding = isBig ? 12.0 : 6.0;
    final double leftPadding = isBig ? 0 : 6.0;

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

  void showBottomModal(BuildContext context, Widget child) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext bc) => child,
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
    isFlat: true,
    onPressed: dismissAlert,
    text: 'Discard',
    textColor: AppColors.buttonText,
    color: AppColors.transparent,
    iconStyle: IconStyle(icon: Icons.keyboard_backspace, color: AppColors.buttonText)
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
}