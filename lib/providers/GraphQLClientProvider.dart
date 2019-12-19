import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin GraphQLClientProvider {
  Widget provideGraphQLClient(Widget child) {
    final HttpLink httpLink = HttpLink(
      uri: 'http://192.168.178.34:8500/graphql',
    );

    // final AuthLink authLink = AuthLink(
      // getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );

    // final Link link = authLink.concat(httpLink);

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: child
    );
  }
}
