import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/widgets/Login/LoggingIn.dart';

mixin LoginHelper {
  void whenLoggedIn(BuildContext context, Better user) {
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

  static Future<String> getIDToken() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await auth.currentUser();

    return await currentUser.getIdToken();
  }

  static Future<Better> getLoggedInUser(BuildContext context) async{
    final String token = await getIDToken();

     if(token != null) {
      return await Better.login(context, token);
     }

     return null;
  }

  Future<Better> signInUser(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebaseUser user = await auth.signInWithCredential(credential);
    final String token = await user.getIdToken();
    assert(!user.isAnonymous);
    assert(token != null);

    return await Better.login(context, token);
  }
}