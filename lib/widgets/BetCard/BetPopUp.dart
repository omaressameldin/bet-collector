import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';

class BetPopUp extends StatelessWidget with BetsConsumer, BetConsumer {
  BetPopUp({ @required this.isCompletedList, @required this.mainContext });

  final bool isCompletedList;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _actionButtons(context)
      ]
    );
  }

  List<ActionButton> _actionButtonsList(BuildContext context, Bets bets, Bet bet) {
    final Color contentColor = AppColors.buttonText;
    final List<ActionButton> actionButtons =  <ActionButton>[
      ActionButton(
        text: 'Edit',
        textColor: contentColor,
        color: AppColors.primary,
        iconStyle: IconStyle(color: contentColor, icon: Icons.edit),
        onPressed: () {},
      ),
      ActionButton(
        text: 'Delete',
        textColor: contentColor,
        color: AppColors.danger,
        iconStyle: IconStyle(color: contentColor, icon: Icons.delete_forever),
        onPressed: () {
          bets.delete(bet);
          Navigator.pop(context);
        },
      ),
    ];

    if (!bet.isCompleted()) {
      actionButtons.insert(0, ActionButton(
        text: 'Done',
        textColor: contentColor,
        color: AppColors.success,
        iconStyle: IconStyle(color: contentColor, icon: Icons.check_circle),
        onPressed: () => bets.markAsCompleted(bet),
      ));
    }

    return actionButtons;
  }

  Widget _actionButtons(BuildContext context) {
    final Bets bets = consumeBets(mainContext);
    final Bet bet = consumeBet(context);
    final List<ActionButton> actionButtons = _actionButtonsList(context, bets, bet);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actionButtons.map((ActionButton button) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child:button.generateButton()
        );
      }).toList()
    );
  }

}