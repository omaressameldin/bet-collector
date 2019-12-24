import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/providers/BetsProvider.dart';

import 'LoggedInPage.dart';

class LoggingIn extends StatelessWidget with BetsProvider {
  const LoggingIn({ @required this.currentUser });
  final Better currentUser;

  @override
  Widget build(BuildContext context) {
    final Bets bets = Bets();

    return provideBets(bets, currentUser, LoggedInPage());
  }
}
