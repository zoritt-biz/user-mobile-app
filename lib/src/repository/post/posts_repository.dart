import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/user_mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/posts_queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class PostRepository {
  final GraphQLClient client;

  PostRepository({@required this.client});

  Future<List<Post>> getPosts(
    int page,
    int perPage,
    String filterDate,
  ) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_POSTS),
        variables: {"page": page, "perPage": perPage, "filterDate": filterDate},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['postPagination']['items'] as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<bool> likePost(String postId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_POST),
        variables: {"postId": postId},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      return false;
    }
    return true;
  }

  Future<bool> unlikePost(String postId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_POST),
        variables: {"postId": postId},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }
}
