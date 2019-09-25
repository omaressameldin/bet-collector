import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInButton extends StatelessWidget with WidgetHelper {
  const SignInButton();

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: AppColors.success,
      shape: ButtonShape.raised,
      isBig: true,
      iconStyle: IconStyle(
        color: AppColors.funky,
        icon: AppIcons.google
      ),
      text: 'oogle Sign In',
      onPressed: () => signInWithGoogle(context),
    ).generateButton();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser user = await auth.signInWithCredential(credential);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);
    afterSiginIn(context, user);
  }
}
