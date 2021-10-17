import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/post_mutations.dart';
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
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['postPagination']['items'] as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<bool> likePost(String userId, String postId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_POST),
        variables: {"user_id": userId, "post_id": postId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      print(result.exception);
      throw result.exception;
    }
    return true;
  }

  Future<bool> unlikePost(String userId, String postId) async {
    final result = await client.query(
      QueryOptions(
          document: gql(UNLIKE_POST),
          variables: {"user_id": userId, "post_id": postId},
          fetchPolicy: FetchPolicy.networkOnly),
    );
    if (result.hasException) {
      print(result.exception);
      throw result.exception;
    }
    return true;
  }
}
