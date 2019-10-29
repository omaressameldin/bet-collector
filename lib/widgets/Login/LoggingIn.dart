import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetsProvider.dart';

import 'LoggedInPage.dart';

class LoggingIn extends StatelessWidget with BetsProvider {
  const LoggingIn({ @required this.currentUser });
  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    final Bets bets = Bets();

    return provideBets(bets, bets.getLoggedInBetter(), LoggedInPage());
  }

}