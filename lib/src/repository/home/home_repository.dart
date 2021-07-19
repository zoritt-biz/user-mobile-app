import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/home.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({@required this.client});

  Future<List<String>> getImages() async {
    final result = await client.query(
      QueryOptions(document: gql(GET_IMAGES)),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['zorittOne']['userAppHomePageImages'] as List;
    return data.map((e) => e.toString()).toList();
  }
}
