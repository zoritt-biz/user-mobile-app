import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/event_mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/event_queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class EventsRepository {
  final GraphQLClient client;

  EventsRepository({@required this.client});

  Future<List<Events>> getEvents(int page, int perPage) async {
    String today = DateTime.now().toString();
    final result = await client.query(
      QueryOptions(
        document: gql(GET_EVENTS),
        variables: {
          "page": page,
          "perPage": perPage,
          "today": today.split(" ")[0],
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['eventPagination']["items"] as List;
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
