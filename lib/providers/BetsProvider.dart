import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:provider/provider.dart';

mixin BetsProvider {
  Widget provideBets(Bets bets, Better better, Widget child) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<Bets>(builder: (_) => bets),
        Provider<Better>(builder: (_) => better),
      ],
      child: child
  );
  }
}