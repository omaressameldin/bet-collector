import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetsProvider {
  Widget provideBets(Bets bets, Better better, BetsConsumer child) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<Bets>(builder: (_) => bets),
        Provider<Better>(builder: (_) => better),
      ],
      child: child
  );
  }
}