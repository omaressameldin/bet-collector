import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/SignIn/SignInPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Long Term Bets',
      home: const SignInPage(),
    );
  }
}
