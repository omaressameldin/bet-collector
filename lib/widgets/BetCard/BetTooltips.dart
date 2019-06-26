import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:intl/intl.dart';


class BetTooltips extends StatelessWidget with WidgetHelper {
  BetTooltips({@required this.bet, this.alignment = MainAxisAlignment.start});

  final MainAxisAlignment alignment;
  final Bet bet;

  final DateFormat _dateFormatter = DateFormat('MMM yyyy');
  final double _bottomIconsSize = 15.0;
  final double _iconSpacing = 1.0;
  final IconStyle _dateIconStyle = IconStyle(
    icon: Icons.date_range,
    color: AppColors.secondary,
  );
  final IconStyle _runningIcon = IconStyle(
    icon: Icons.directions_run,
    color: AppColors.primary,
  );
  final IconStyle _completedIcon = IconStyle(
    icon: Icons.check_circle,
    color: AppColors.success,
  );
  final TextStyle _iconTextStyle = TextStyle(
    color: AppColors.cardText,
    fontWeight: FontWeight.bold
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          buildDividedContainer(false, Wrap(
            spacing: _iconSpacing,
            children: <Widget>[
              Icon(
                bet.isCompleted() ? _completedIcon.icon : _runningIcon.icon,
                color: bet.isCompleted() ? _completedIcon.color : _runningIcon.color,
                size: _bottomIconsSize,
              ),
              Text(
                bet.isCompleted() ? 'Completed' : 'Running',
                style: _iconTextStyle,
              ),
            ],
          )),
          buildDividedContainer(false, Wrap(
            spacing: _iconSpacing,
            children: <Widget>[
              Icon(
                _dateIconStyle.icon,
                color: _dateIconStyle.color,
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