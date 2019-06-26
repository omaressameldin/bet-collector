import 'package:flutter/material.dart';
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
}