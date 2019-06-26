import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetsProvider {
  Widget provideBets(Bets bets, BetsConsumer child) {
    return ChangeNotifierProvider<Bets>(
      builder: (_) => bets,
      child: child
    );
  }
}