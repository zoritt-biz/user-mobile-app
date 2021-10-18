import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink _httpLink = HttpLink(
  //'http://192.168.1.107:8080/',
  'https://zoritt-new-api.herokuapp.com/',
);

final AuthLink authLink = AuthLink(
  getToken: () async =>
      'BearereyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTUwMDliNGZlMWY1YTJhYThhYmM4M2IiLCJlbWFpbCI6Im5hZG1pbkBnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJOYXRobmFlbCIsIm1pZGRsZU5hbWUiOiJZZXdvbmR3b3NlbiIsImxhc3ROYW1lIjoiQWthbGUiLCJwaG9uZU51bWJlciI6IjA5NDY2MjUyNjQiLCJyb2xlcyI6WyJOT1JNQUwiLCJBRE1JTiJdLCJpYXQiOjE2MzI5NDc3OTEsImV4cCI6MTYzNjU0Nzc5MX0.RkH5vTbQQiSMllkVwFuAqp_TRx8TuVKgXEfiTrHeaDo',
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
