import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/mixins/LoginHelper.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';

class SignInButton extends StatelessWidget with LoginHelper {
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
    final Better user = await signInUser(context);

    whenLoggedIn(context, user);
  }
}
