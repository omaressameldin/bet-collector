import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
mixin WidgetHelper {
  Container buildDividedContainer(bool isBig, Widget child, {bool isLast: false}) {
    double rightPadding = isBig ? 12.0 : 6.0;
    double leftPadding = isBig ? 0 : 6.0;

    return Container(
          padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
          decoration: new BoxDecoration(
            border: isLast ? null : new Border(right: new BorderSide(
              width: 1.0 ,
              color: AppColors.secondary
            ))
          ),
          child: child,
      );
  }

  showBottomModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) => child,
    );
  }
}