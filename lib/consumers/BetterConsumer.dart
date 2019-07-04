import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:provider/provider.dart';

mixin BetterConsumer {
  Better consumeBetter(BuildContext context) => Provider.of<Better>(context);
}