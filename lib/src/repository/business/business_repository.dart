import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class BusinessRepository {
  final GraphQLClient client;
  final FirebaseStorage firebaseStorage;

  BusinessRepository({
    @required this.client,
    @required this.firebaseStorage,
  }) : assert(GraphQLClient != null && FirebaseStorage != null);

  Future<Business> getBusiness(String id) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_DETAIL),
        variables: {"id": id},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessById'];
    return new Business.fromJson(data);
  }

  Future<Business> getBusinessDetail(String id) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_DETAIL),
        variables: {"id": id},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessById'];
    return new Business.fromJson(data);
  }

  Future<List<Business>> getSponsoredBusinesses(int limit) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_SPONSORED_BUSINESSES),
        variables: {
          "subscriptions": "FEATHER_4",
          "limit": limit,
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessMany'] as List;
    return [...data.map((e) => new Business.fromJson(e))];
  }

  Future<List<BusinessList>> getBusinessList() async {
    final results = await client.query(
      QueryOptions(document: gql(GET_BUSINESS_LIST_MANY)),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['businessListMany'] as List;
    return data.map((e) => BusinessList.fromJson(e)).toList();
  }

  Future<List<Business>> getFavoritesList(String id) async {
    final results = await client.query(
      QueryOptions(
        document: gql(GET_FAVORITES_LIST_MANY),
        variables: {"id": id},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['userById']['favorites'] as List;
    return data.map((e) => Business.fromJson(e)).toList();
  }

  Future<List<Business>> getBusinesses(
    String query,
    int skip,
    int limit,
  ) async {
    final results = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_MANY),
        variables: {
          "searchArray": [...query.split(" ").map((e) => e.toLowerCase())],
          "limit": limit,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['businessMany'] as List;
    return data.map((e) => Business.fromJson(e)).toList();
  }
}
