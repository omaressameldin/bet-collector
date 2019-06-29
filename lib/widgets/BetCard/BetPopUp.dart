import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetActions.dart';
import 'package:long_term_bets/widgets/BetCard/BetDetails.dart';
import 'package:long_term_bets/widgets/BetCard/Betters.dart';
import 'BetTooltips.dart';

class BetPopUp extends StatelessWidget with
  WidgetHelper,
  BetsConsumer,
  BetConsumer,
  BetterConsumer
{
  BetPopUp({ @required this.mainContext });

  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final Bets bets = consumeBets(mainContext);
    final Bet bet = consumeBet(context);
    final Better currentUser = consumeBetter(mainContext);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.verticalWidgetPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Betters(better: bet.better, accepter: bet.accepter, mainContext: mainContext),
            BetActions(mainContext: mainContext, bets: bets, bet: bet),
            BetTooltips(bet: bet, alignment: WrapAlignment.center, currentUser: currentUser),
            BetDetails(bet: bet),
          ]
        )
      ),
    );
  }
}