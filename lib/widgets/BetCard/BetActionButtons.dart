import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetActions.dart';

class BetActionButtonsState extends BetActionsState<BetActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _actionButtons().map((ActionButton button) {
        return Padding(
          padding:  EdgeInsets.all(AppSizes.widgetMargin),
          child:button.generateButton()
        );
      }).toList()
    );
  }

  ActionButton _editButton() {
    return createActionButton('Edit', AppColors.secondary, AppIcons.edit, editBet);
  }

  ActionButton _deleteButon() {
    return createActionButton(
      'Delete',
      AppColors.danger,
      AppIcons.delete,
      () {
        deleteBet();
        Navigator.pop(widget.mainContext);
      },
    );
  }

  ActionButton _setProgressButton() {
    if (!widget.bet.isCompleted()) {
      return createActionButton(
        'Done',
        AppColors.success,
        AppIcons.completedBets,
        markBetAsDone,
      );
    } else {

      return createActionButton(
        'Running',
        AppColors.info,
        AppIcons.runningBets,
        markBetAsRunning,
      );
    }
  }

  List<ActionButton> _actionButtons() {
    return <ActionButton>[
      _setProgressButton(),
      _editButton(),
      _deleteButon(),
    ];
  }
}

class BetActionButtons extends BetActions {
  BetActionButtons({
    @required Bets bets,
    @required Bet bet,
    @required BuildContext mainContext,
    @required Function onEdit
  }): super(
    bets: bets,
    bet: bet,
    mainContext: mainContext,
    onEdit: onEdit,
  );

  @override
  BetActionButtonsState createState() => BetActionButtonsState();
}