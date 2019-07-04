import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetConsumer{
  Bet consumeBet(BuildContext context) => Provider.of<Bet>(context);
}