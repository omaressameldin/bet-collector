import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';

class BetTooltips extends StatelessWidget with WidgetHelper {
  BetTooltips({
    @required this.bet,
    @required this.currentUser,
    this.alignment = WrapAlignment.start
  });

  final WrapAlignment alignment;
  final Bet bet;
  final Better currentUser;

  final DateFormat _dateFormatter = DateFormat('MMM yyyy');
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> tooltips = <Widget>[
      _stateTooltip(),
      _dateTooltip(!bet.isCompleted())
    ];
    if (bet.isCompleted()) {
      tooltips.add(_winnerTooltip(context));
    }

    return Container(
      padding: EdgeInsets.only(top: AppSizes.widgetMargin),
      child: Wrap(
        alignment: alignment,
        children: tooltips,
      ),
    );
  }

  Widget _stateTooltip() {
    return buildDividedContainer(false, Wrap(
      spacing: AppSizes.iconSpacing,
      children: <Widget>[
        Icon(
          bet.isCompleted() ? _completedIcon.icon : _runningIcon.icon,
          color: bet.isCompleted() ? _completedIcon.color : _runningIcon.color,
          size: AppSizes.smallIconSize,
        ),
        Text(
          bet.isCompleted() ? 'Done' : 'Running',
          style: TextStyles.tooltipStyle,
        ),
      ],
    ));
  }

  Widget _dateTooltip(bool isLast) {
    final IconStyle dateIconStyle = bet.isCompleted() ? _completedDateIconStyle :
      _expiryDateIconStyle;
    return buildDividedContainer(
      false,
      Tooltip(
        padding: EdgeInsets.all(AppSizes.widgetMargin),
        message: bet.isCompleted() ? 'Completion Date' : 'Expiration Date',
        child: Wrap(
          spacing: AppSizes.iconSpacing,
          children: <Widget>[
            Icon(
              dateIconStyle.icon,
              color: dateIconStyle.color,
              size: AppSizes.smallIconSize
            ),
            Text(
              _dateFormatter.format(
                bet.isCompleted() ?  bet.completionDate : bet.expiryDate,
              ),
              style: TextStyles.tooltipStyle,
            ),
          ],
        ),
      ),
      isLast: isLast
    );
  }

  Widget _winnerTooltip(BuildContext context) {
    final String winnerName = (currentUser == bet.winner) ? 'You' : bet.winner.name;
    return buildDividedContainer(
      false,
      Tooltip(
        padding: EdgeInsets.all(AppSizes.widgetMargin),
        message: 'Winner: $winnerName',
        child: Wrap(
        spacing: AppSizes.iconSpacing,
        children: <Widget>[
          Icon(
            _winnerIcon.icon,
            color: _winnerIcon.color,
            size: AppSizes.smallIconSize
          ),
          Avatar(avatar: bet.winner.avatar, size: AvatarSize.small),
        ],
      )
      ),
      isLast: true
    );
  }
}