import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/posts_queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class PostRepository{
  final GraphQLClient client;
  PostRepository({@required this.client});

  Future<List<Post>> getPosts(int limit,String sort,String filterDate,int skip)async{
    final result = await client.query(
      QueryOptions(
        document: gql(GET_ALL_POSTS),
        variables: {
          "skip":skip,
          "limit": limit,
          "sort":sort,
          "filterDate":filterDate,

        },
      ),
    );

    if (result.hasException) {
      print(result.hasException);
      throw result.exception;
    }


    final data = result.data['postMany'] as List;
    // if(data.isNotEmpty){
      return data.map((e)=> Post.fromJson(e)).toList();

    // }else{
    //   return [];
    // }

  }
}