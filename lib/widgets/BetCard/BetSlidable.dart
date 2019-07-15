
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/BetCard/BetActions.dart';

class BetSlidableState extends BetActionsState<BetSlidable> {

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: widget.card,
        actions: <Widget>[
          IconSlideAction(
            color: widget.bet.isCompleted() ? AppColors.info : AppColors.success,
            icon: widget.bet.isCompleted() ? AppIcons.runningBets : AppIcons.completedBets,
            foregroundColor: AppColors.buttonText,
            onTap: () => widget.bet.isCompleted() ? markBetAsRunning() : markBetAsDone(),

          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            color: AppColors.danger,
            icon: AppIcons.delete,
            foregroundColor: AppColors.buttonText,
            onTap: () => deleteBet(),
          ),
        ],
      );
  }
}

class BetSlidable extends BetActions {
  BetSlidable({
    @required Bets bets,
    @required Bet bet,
    @required BuildContext mainContext,
    @required this.card,
  }): super(
    bets: bets,
    bet: bet,
    mainContext: mainContext
  );

  final Widget card;

  @override
  BetSlidableState createState() =>  BetSlidableState();
}
