import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

enum BetsType {
  all,
  running,
  won,
  lost
}

mixin BetsConsumer {
  Bets consumeBets(BuildContext context) => Provider.of<Bets>(context);

  Future<List<Bet>> betsList(BuildContext context, BetsType type) async {
    final Bets bets = consumeBets(context);

    switch(type) {
      case BetsType.all: return await bets.allBets(context);
      case BetsType.running: return bets.runningBets.toList();
      case BetsType.won: return bets.wonBets.toList();
      default: return bets.lostBets.toList();
    }
  }
}