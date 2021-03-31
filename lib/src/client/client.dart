import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  'https://zoritt-back-end-api.herokuapp.com/'
);

final _link = Link.from([_httpLink]);

GraphQLClient client() {
  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: _link,
  );
}
