import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';

class BetTooltips extends StatelessWidget with WidgetHelper {
  BetTooltips({@required this.bet, this.alignment = WrapAlignment.start});

  final WrapAlignment alignment;
  final Bet bet;

  final DateFormat _dateFormatter = DateFormat('MMM yyyy');
  final double _bottomIconsSize = 15.0;
  final double _iconSpacing = 2.0;
  final IconStyle _expiryDateIconStyle = IconStyle(
    icon: AppIcons.futureBet,
    color: AppColors.secondary,
  );
  final IconStyle _completedDateIconStyle = IconStyle(
    icon: AppIcons.expiredBet,
    color: AppColors.secondary,
  );
  final IconStyle _runningIcon = IconStyle(
    icon: AppIcons.runningBets,
    color: AppColors.info,
  );
  final IconStyle _completedIcon = IconStyle(
    icon: AppIcons.completedBets,
    color: AppColors.success,
  );
  final IconStyle _winnerIcon = IconStyle(
    icon: AppIcons.betWinner,
    color: AppColors.winner,
  );
  final TextStyle _iconTextStyle = TextStyle(
    color: AppColors.cardText,
    fontWeight: FontWeight.bold
  );


  @override
  Widget build(BuildContext context) {
    final List<Widget> tooltips = <Widget>[
      _stateTooltip(),
      _dateTooltip(!bet.isCompleted())
    ];
    if (bet.isCompleted()) {
      tooltips.add(_winnerTooltip());
    }

    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: Wrap(
        alignment: alignment,
        children: tooltips,
      ),
    );
  }

  Widget _stateTooltip() {
    return buildDividedContainer(false, Wrap(
      spacing: _iconSpacing,
      children: <Widget>[
        Icon(
          bet.isCompleted() ? _completedIcon.icon : _runningIcon.icon,
          color: bet.isCompleted() ? _completedIcon.color : _runningIcon.color,
          size: _bottomIconsSize,
        ),
        Text(
          bet.isCompleted() ? 'Done' : 'Running',
          style: _iconTextStyle,
        ),
      ],
    ));
  }

  Widget _dateTooltip(bool isLast) {
    final IconStyle dateIconStyle = bet.isCompleted() ? _completedDateIconStyle :
      _expiryDateIconStyle;
    return buildDividedContainer(
      false,
      Wrap(
        spacing: _iconSpacing,
        children: <Widget>[
          Icon(
            dateIconStyle.icon,
            color: dateIconStyle.color,
            size: _bottomIconsSize,
          ),
          Text(
            _dateFormatter.format(
              bet.isCompleted() ?  bet.completionDate : bet.expiryDate,
            ),
            style: _iconTextStyle

          ),
        ],
      ),
      isLast: isLast
    );
  }

  Widget _winnerTooltip() {
    return buildDividedContainer(
      false,
      Wrap(
        spacing: _iconSpacing,
        children: <Widget>[
          Icon(
            _winnerIcon.icon,
            color: _winnerIcon.color,
            size: _bottomIconsSize,
          ),
          Avatar(avatar: bet.winner.avatar, size: AvatarSize.small),
        ],
      ),
      isLast: true
    );
  }
}