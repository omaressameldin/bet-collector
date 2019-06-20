import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

abstract class BetsConsumer extends StatelessWidget {
  final int betIndex;
  final bool isCompletedList;

  BetsConsumer({
    @required this.betIndex,
    @required this.isCompletedList,
  });

  Widget build(BuildContext context) {
    Bets bets = Provider.of<Bets>(context);
    List<Bet> betsArray = isCompletedList ? bets.completedBets : bets.allBets;

    return renderChild(context, betsArray[betIndex], bets);
  }

  Widget renderChild(BuildContext context, Bet bet, Bets bets);
}