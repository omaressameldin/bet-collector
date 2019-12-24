import 'package:flutter/material.dart';
import 'package:long_term_bets/providers/GraphQLClientProvider.dart';
import 'package:long_term_bets/widgets/SignIn/SignInPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with GraphQLClientProvider {
  @override
  Widget build(BuildContext context) {
    return provideGraphQLClient(
      const MaterialApp(title: 'Long Term Bets', home: SignInPage())
    );
  }
}
