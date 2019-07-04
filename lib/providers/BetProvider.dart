import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetProvider {
  Widget provideBet(Bet bet, Widget child) {
    return ChangeNotifierProvider<Bet>.value(
      value: bet,
      child: child
    );
  }
}