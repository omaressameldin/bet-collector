import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:long_term_bets/widgets/Login/LoggingIn.dart';

mixin LoginHelper {
  void whenLoggingIn(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) {
          return LoggingIn(currentUser: user);
        },
      ),
    );
  }

  void signOutGoogle(BuildContext context) async{
    await GoogleSignIn().signOut();
    Navigator.of(context).pop();
  }
}