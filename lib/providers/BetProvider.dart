import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetProvider {
  Widget provideBet(Bet bet, BetConsumer child) {
    return ChangeNotifierProvider(
      builder: (_) => bet,
      child: child
    );
  }
}