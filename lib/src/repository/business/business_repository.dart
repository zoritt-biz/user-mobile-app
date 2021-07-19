import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/location.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class BusinessRepository {
  final GraphQLClient client;

  BusinessRepository({@required this.client}) : assert(GraphQLClient != null);

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

  Future<Business> getBusinessesLoggedIn(String id, String userId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_DETAIL_LOGGED_IN),
        variables: {"business_id": id, "user_id": userId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data["businessByIdLoggedIn"];
    return new Business.fromJson(data);
  }

  Future<List<Business>> getSponsoredBusinesses(int limit) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_SPONSORED_BUSINESSES),
        variables: {
          "subscriptions": "SPONSORED",
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
      print(results.exception);
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
    final data = results.data['userOne']['favorites'] as List;
    return data.map((e) => Business.fromJson(e)).toList();
  }

  Future<List<Business>> getBusinesses(
    String query,
    int skip,
    int limit,
  ) async {
    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");

    final results = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_MANY),
        variables: {
          "searchArray": businessName,
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

  Future<List<Business>> getRelatedBusinesses({
    String query,
    String skipId,
    int limit,
  }) async {
    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");

    final results = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_RELATED_MANY),
        variables: {"searchArray": businessName, "limit": limit, "id": skipId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['businessMany'] as List;
    return data.map((e) => Business.fromJson(e)).toList();
  }

  Future<List<Business>> getBusinessesByFilter(
      {String query, int skip, int limit}) async {
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");

    final results = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_BY_FILTER),
        variables: {
          "searchArray": businessName,
          "day": days[DateTime.now().weekday - 1],
          "limit": limit
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

  Future<List<Location>> getLocation(String query) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=AIzaSyDikeOK8HPpndoWQSzE891tDULuSZXlKv4&sessiontoken=1234567890&component=country:et";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) {
      throw "Failed to load data!";
    }

    final li = jsonDecode(res.body)["predictions"] as List;
    return li
        .map((data) => Location(
            description: data["description"], placeId: data["place_id"]))
        .toList();
  }

  Future<dynamic> getGeocode(String placeId) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyDikeOK8HPpndoWQSzE891tDULuSZXlKv4&placeid=$placeId";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) {
      throw "Failed to load data!";
    }

    final li = jsonDecode(res.body)["result"];
    return LatLng(
        li["geometry"]["location"]["lat"], li["geometry"]["location"]["lng"]);
  }

  Future<bool> likeBusiness(String userId, String businessId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_BUSINESS),
        variables: {"user_id": userId, "business_id": businessId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  Future<bool> unlikeBusiness(String userId, String businessId) async {
    final result = await client.query(
      QueryOptions(
          document: gql(UNLIKE_BUSINESS),
          variables: {"user_id": userId, "business_id": businessId},
          fetchPolicy: FetchPolicy.networkOnly),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  Future<List<Business>> searchForBusinessesByLocation({
    String query,
    int limit,
    int skip,
    double km,
    double lat,
    double lng,
  }) async {
    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESSES_BY_LOCATION),
        variables: {
          "lat": lat,
          "lng": lng,
          "distance": km,
          "query": businessName
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessFilterByLocation'] as List;
    return [...data.map((e) => new Business.fromJson(e))];
  }

  Future<List<Business>> searchForBusinessesByFilterAndLocation({
    String query,
    int limit,
    int skip,
    double lat,
    double km,
    double lng,
  }) async {
    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESSES_BY_FILTER_AND_LOCATION),
        variables: {
          "lat": lat,
          "lng": lng,
          "distance": km,
          "query": businessName
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessFilterByLocationAndFilter'] as List;
    return [...data.map((e) => new Business.fromJson(e))];
  }

  Future<List<Business>> searchForBusinessesByFilter({
    String query,
    int limit,
    int skip,
  }) async {
    List<String> businessName = [
      ...query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    businessName.removeWhere((element) => element == "");
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESSES_BY_FILTER),
        variables: {
          "query": businessName,
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['businessFilterByFilter'] as List;
    return [...data.map((e) => new Business.fromJson(e))];
  }
}
