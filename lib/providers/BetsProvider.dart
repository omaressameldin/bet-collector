import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetsProvider {
  Widget provideBets(Bets bets, String betterId, BetsConsumer child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Bets>(builder: (_) => bets),
        Provider<String>(builder: (_) => betterId),
      ],
      child: child
  );
  }
}