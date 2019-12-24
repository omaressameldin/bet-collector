import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:long_term_bets/data/Bets.dart';

mixin QueriesHelper {

  static Future<QueryResult> makeQuery(BuildContext context, String document) async {
    final GraphQLClient client = GraphQLProvider.of(context).value;
    final QueryResult res = await client.mutate(MutationOptions(
      document: document
    ));

    return res;
  }

  static String loginUser(String token) {
    return '''
      mutation{
        loginUser(input: {
          api: "v1",
          auth_id: "$token",
        }){
          user {
            id
            name
            email
            avatar
          }
        }
      }
    ''';
  }

  static String readAllUsers(String token) {
    return '''
      query {
        readAllUsers(input: {
          api: "v1",
          token: "$token"
        }){
          users {
            email
            name
            avatar
            id
          }
        }
      }
    ''';
  }

    static String readAllBets(String token) {
    return '''
      query {
        readAllBets(input: {
          api: "v1",
          token: "$token",
          limit: -1,
          page: -1,
        }){
          bets {
            id
            description
            payment
            accepter {
              email
              name
              avatar
              id
            }
            better {
              email
              name
              avatar
              id
            }
            expiryDate { seconds }
            createdAt { seconds }
            completionDate { seconds }
          }
        }
      }
    ''';
  }

  static String createBet(String token, Bet bet) {
    return '''
      mutation{
        createBet(input: {
          api:"v1",
          token: "$token",
          bet: {
            description: "${bet.description}",
            payment: "${bet.payment}",
            accepter_id: "${bet.accepter.id}",
            expiry_date: { seconds: ${bet.timeInSeconds()} }
          }
        }) {
          id
        }
      }
    ''';
  }

  static String deleteBet(String token, Bet bet) {
    return '''
      mutation{
        deleteBet(input: {
          id: "${bet.id}",
          token: "$token",
          api: "v1"
        }){
          api
        }
      }
    ''';
  }
}
