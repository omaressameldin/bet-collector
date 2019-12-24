import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/BetCard/WinnerPicker.dart';

abstract class BetActionsState<T extends BetActions> extends State<T> with
  WidgetHelper,
  BetterConsumer
{
  Better _selected;

  final Color contentColor = AppColors.buttonText;

  @override
  void initState() {
    super.initState();
    _selected = widget.bet.better;
  }

  @override
  Widget build(BuildContext context);

  void _setSelected(Better value) {
   setState(() {
    _selected = value;
   });
  }

  ActionButton createActionButton(
    String text,
    Color background,
    IconData icon,
    Function onPressed,
    ) {
    return ActionButton(
      text: text,
      color: background,
      iconStyle: IconStyle(color: contentColor, icon: icon),
      onPressed: onPressed,
    );
  }

  void editBet() {
    widget.onEdit();
  }

  void deleteBet() {
    widget.bets.delete(widget.mainContext, widget.bet);
    showSnackBar(
      'Bet deleted!',
      widget.mainContext,
      action: SnackBarAction(
        label: 'undo',
        onPressed: widget.bets.undoDeleteFn(widget.mainContext, widget.bet),
      ),
    );
  }

  ActionButton _setWinnerButton() {
    final Function pressFn = () {
      widget.bets.markAsCompleted(widget.mainContext, widget.bet, _selected);
    };
    return createActionButton('Confirm', AppColors.success, AppIcons.betWinner, pressFn);
  }

  void markBetAsRunning() => widget.bets.markAsRunning(widget.mainContext, widget.bet);

  void markBetAsDone() {
    final WinnerPicker winnerPicker = WinnerPicker(
      accepter: widget.bet.accepter,
      better: widget.bet.better,
      context: widget.mainContext,
      onChanged: _setSelected,
    );
    showAlert(
      widget.mainContext,
      '🤓 Who Won?',
      winnerPicker,
      <ActionButton>[_setWinnerButton()]
    );
  }
}

abstract class BetActions extends StatefulWidget {
  BetActions({
    @required this.bets,
    @required this.bet,
    @required this.mainContext,
    this.onEdit,
  }): super(key: UniqueKey());

  final Bets bets;
  final Bet bet;
  final BuildContext mainContext;
  final Function onEdit;

  @override
  BetActionsState<BetActions> createState();
}