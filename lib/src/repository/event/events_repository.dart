import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/event_queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class EventsRepository {
  final GraphQLClient client;

  EventsRepository({@required this.client});

  Future<List<Events>> getEvents(int limit, String sort) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_ALL_EVENTS),
        variables: {
          "limit": limit,
          "sort": sort,
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['eventMany'] as List;
    return data.map((e) => Events.fromJson(e)).toList();
  }
}
