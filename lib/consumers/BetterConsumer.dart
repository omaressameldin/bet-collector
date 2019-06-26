import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:provider/provider.dart';

mixin BetterConsumer on Widget {
  Better consumeBetter(BuildContext context) => Provider.of<Better>(context);
}