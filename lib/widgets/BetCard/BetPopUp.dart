import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetDetails.dart';
import 'package:long_term_bets/widgets/BetCard/Betters.dart';
import 'package:long_term_bets/widgets/EditBet/EditBetWrapper.dart';
import 'BetActionButtons.dart';
import 'BetTooltips.dart';

class BetPopUpState extends State<BetPopUp> with WidgetHelper, BetsConsumer, BetConsumer {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final Bet bet = consumeBet(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.verticalWidgetPadding),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 500),
          firstChild: _renderBet(bet),
          secondChild: EditBetWrapper(onDone: _toggleEditing, bet: bet),
          crossFadeState: _isEditing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }

  Widget _renderBet(Bet bet) {
    final Bets bets = consumeBets(widget.mainContext);

    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Betters(
              better: bet.better,
              accepter: bet.accepter,
              mainContext: widget.mainContext,
            ),
            BetActionButtons(
              mainContext: widget.mainContext,
              bets: bets,
              bet: bet,
              onEdit: _toggleEditing
            ),
            BetTooltips(bet: bet, alignment: WrapAlignment.center, context: widget.mainContext),
            horizontalDivider(),
            BetDetails(bet: bet),
          ]
        );
  }

  void _toggleEditing() {
    setState(() => _isEditing = !_isEditing);
  }
}

class BetPopUp extends StatefulWidget {
  const BetPopUp({ @required this.mainContext });

  final BuildContext mainContext;

  @override
  State<StatefulWidget> createState() => BetPopUpState();

}