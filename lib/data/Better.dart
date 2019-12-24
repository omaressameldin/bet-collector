import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:long_term_bets/mixins/LoginHelepr.dart';
import 'package:long_term_bets/mixins/QueriesHelper.dart';

class Better with QueriesHelper, LoginHelper {

  Better({
    @required this.id,
    @required this.name,
    @required this.avatar,
    @required this.email,
  });

  final String id;
  final String name;
  final NetworkImage avatar;
  final String email;

 @override
  bool operator ==(dynamic other) {
    return other is Better && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  static Future<List<Better>> filterBetters(BuildContext context, String input) async {
    if (input.isEmpty) {
      return Future<List<Better>>(() => <Better>[]);
    }

    final GraphQLClient client = QueriesHelper.getClient(context);
    final String token = await LoginHelper.getIDToken();
    final QueryResult res = await QueriesHelper.makeQuery(
      client, QueriesHelper.readAllUsers(token)
    );
    final List<dynamic> usersResult =res.data['readAllUsers']['users'];

    final List<Better> betters = usersResult.map((dynamic user) => Better(
      id: user['id'],
      email: user['email'],
      name: user['name'],
      avatar: NetworkImage(user['avatar'])
    )).toList();

    return betters.where((Better b) {
      return b.name.toLowerCase().contains(input.toLowerCase());
    }).toList();
  }

  static Future<Better> login(BuildContext context, String token) async {
  final GraphQLClient client = QueriesHelper.getClient(context);
  final QueryResult res = await QueriesHelper.makeQuery(
    client, QueriesHelper.loginUser(token)
  );
  final Map<String, dynamic> userResult =res.data['loginUser']['user'];

  return Better(
    avatar: NetworkImage(userResult['avatar']),
    email: userResult['email'],
    name: userResult['name'],
    id: userResult['id']
    );
  }
}