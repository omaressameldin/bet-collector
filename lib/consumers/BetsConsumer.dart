import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

enum BetsType {
  all,
  running,
  won,
  lost
}

mixin BetsConsumer on Widget {
  Bets consumeBets(BuildContext context) => Provider.of<Bets>(context);

  List<Bet> betsList(BuildContext context, BetsType type) {
    final Bets bets = consumeBets(context);

    switch(type) {
      case BetsType.all: return bets.allBets.toList();
      case BetsType.running: return bets.runningBets.toList();
      case BetsType.won: return bets.wonBets.toList();
      default: return bets.lostBets.toList();
    }
  }
}