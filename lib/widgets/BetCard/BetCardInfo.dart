import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:intl/intl.dart';


class BetCardInfo extends StatelessWidget with WidgetHelper {
  final DateFormat _dateFormatter = new DateFormat("MMM yyyy");
  final double _bottomIconsSize = 15.0;
  final double _iconSpacing = 1.0;
  final Color _runningIconColor = AppColors.primary;
  final Color _completedIconColor = AppColors.success;
  final Color _iconColor = AppColors.secondary;
  final TextStyle _iconTextStyle = TextStyle(
    color: AppColors.cardText,
    fontWeight: FontWeight.bold
  );

  final Bet bet;
  BetCardInfo({@required this.bet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildDividedContainer(false, Wrap(
            spacing: _iconSpacing,
            children: <Widget>[
              Icon(
                bet.isCompleted() ? Icons.check_circle : Icons.directions_run,
                color: bet.isCompleted() ? _completedIconColor : _runningIconColor,
                size: _bottomIconsSize,
              ),
              Text(
                bet.isCompleted() ? "Completed" : "Running",
                style: _iconTextStyle,
              ),
            ],
          )),
          buildDividedContainer(false, Wrap(
            spacing: _iconSpacing,
            children: <Widget>[
              Icon(
                Icons.date_range,
                color: _iconColor,
                size: _bottomIconsSize,
              ),
              Text(
                _dateFormatter.format(
                  bet.isCompleted() ?  bet.completionDate : bet.expiryDate,
                ),
                style: _iconTextStyle

              ),
            ],
          ), isLast: true)
        ],
      ),
    );
  }
}