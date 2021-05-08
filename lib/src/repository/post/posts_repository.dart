import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/post_mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/posts_queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class PostRepository {
  final GraphQLClient client;

  PostRepository({@required this.client});

  Future<List<Post>> getPosts(
    int limit,
    String sort,
    String filterDate,
    int skip,
  ) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_ALL_POSTS),
        variables: {
          "skip": skip,
          "limit": limit,
          "sort": sort,
          "filterDate": filterDate
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['postMany'] as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Post>> getPostLoggedIn(
      {String userId, int limit, String sort}) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_POSTS_LOGGED_IN),
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
    final data = result.data['getPostLoggedIn'] as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<bool> likeEvent(String userId, String eventId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_POST),
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
          document: gql(UNLIKE_POST),
          variables: {"user_id": userId, "event_id": eventId},
          fetchPolicy: FetchPolicy.networkOnly),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }
}
