import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/BetCard/BetSlidable.dart';
import 'package:long_term_bets/widgets/BetCard/BetTooltips.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/widgets/BetCard/BetPopUp.dart';

class BetCard extends StatelessWidget with
  WidgetHelper,
  BetterConsumer,
  BetConsumer,
  BetsConsumer,
  BetProvider
{
  final Color _iconColor = AppColors.secondary;

  @override
  Widget build(BuildContext context) {
    final Bet bet = consumeBet(context);
    final Bets bets = consumeBets(context);

    return Card(
      elevation: AppSizes.elevation,
      margin: EdgeInsets.symmetric(vertical: AppSizes.widgetMargin),
      child: BetSlidable(
        bets: bets,
        bet: bet,
        mainContext: context,
        card: _buildTile(context, bet),
      )
    );
  }

  ListTile _buildTile(BuildContext context, Bet bet) {
    final Better currentUser = consumeBetter(context);
    final Better otherSide = bet.getOtherSide(currentUser);

    return ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalWidgetPadding,
          vertical: AppSizes.verticalWidgetPadding,
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDividedContainer(
              true,
              Avatar(avatar: otherSide.avatar, size: AvatarSize.big),
            )
          ],
        ),
        title: Text(
          bet.description,
          style: TextStyles.titleStyle,
          maxLines: 2,
        ),
        subtitle: BetTooltips(bet: bet),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: AppSizes.minButtonSize,
              padding: EdgeInsets.all(AppSizes.zeroSpacing),
              shape: const CircleBorder(side: BorderSide.none),
              child: FlatButton(
                onPressed: () => showBottomModal(
                  context,
                  provideBet(
                    bet,
                    BetPopUp(mainContext: context),
                  ),
                ),
                child: Icon(
                  AppIcons.showPopup,
                  color: _iconColor,
                  size: AppSizes.mediumIconSize,
                ),
              )
            )
          ]
        )
    );
  }
}
