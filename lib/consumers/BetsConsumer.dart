import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetsConsumer on Widget {
  Widget betProvider(Bet bet, BetConsumer child) {
    return ChangeNotifierProvider(
      builder: (_) => bet,
      child: child
    );
  }

  Bets consumeBets(BuildContext context) => Provider.of<Bets>(context);

  List<Bet> betsList(BuildContext context, bool isCompletedList) {
    Bets bets = consumeBets(context);
    return isCompletedList ? bets.completedBets : bets.allBets;
  }


}