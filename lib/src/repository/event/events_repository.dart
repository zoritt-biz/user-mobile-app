import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/event_mutations.dart';
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

  Future<List<Events>> getEventsLoggedIn(
      {String userId, int limit, String sort}) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_ALL_EVENTS_LOGGED_IN),
        variables: {
          "limit": limit,
          "sort": sort,
          "user_id": userId,
          "fromDate": "2021-05-03"
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['getEventsLoggedIn'] as List;
    return data.map((e) => Events.fromJson(e)).toList();
  }

  Future<bool> likeEvent(String userId, String eventId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_EVENT),
        variables: {"user_id": userId, "event_id": eventId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  Future<bool> unlikeEvent(String userId, String eventId) async {
    final result = await client.query(
      QueryOptions(
          document: gql(UNLIKE_EVENT),
          variables: {"user_id": userId, "event_id": eventId},
          fetchPolicy: FetchPolicy.networkOnly),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }
}
