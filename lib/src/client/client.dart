import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  // 'http://192.168.1.107:8080/',
  'https://zoritt-new-api.herokuapp.com/',
);

final AuthLink authLink = AuthLink(
  getToken: () async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return 'Bearer ';
    return 'Bearer $jwt';
  },
);

final Link _link = authLink.concat(_httpLink);

class Client {
  static final Client _client = Client._internal();

  factory Client() => _client;

  Client._internal();

  GraphQLClient connect = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: _link,
  );
}
