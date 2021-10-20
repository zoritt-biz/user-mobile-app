import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/pop-up.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';
import 'package:zoritt_mobile_app_user/src/models/location.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/models/pop-up.dart';

class BusinessRepository {
  final GraphQLClient client;

  BusinessRepository({@required this.client}) : assert(GraphQLClient != null);

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
        variables: {"limit": limit},
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['sponsoredMany'] as List;
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

  Future<List<Business>> getFavoritesList() async {
    final results = await client.query(
      QueryOptions(
        document: gql(GET_FAVORITES_LIST_MANY),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['user']['favorites'] as List;
    return data.map((e) => Business.fromJson(e)).toList();
  }

  Future<List<Business>> getBusinessesByFilter({
    Filter filter,
    int page,
    int perPage,
  }) async {
    List<String> query = [
      ...filter.query
          .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), ' ')
          .replaceAll('&', ' ')
          .replaceAll('.', ' ')
          .split(" ")
          .map((e) => e.toLowerCase())
    ];
    query.removeWhere((element) => element == "");

    final results = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS_BY_FILTER),
        variables: {
          "category": filter.category,
          "distance": filter.distance,
          "query": query,
          "openNow": filter.openNow,
          "lat": filter.lat,
          "lng": filter.lng,
          "page": page,
          "perPage": perPage
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }
    final data = results.data['getBusinessesByFilter']['items'] as List;
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

  Future<bool> likeBusiness(String businessId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_BUSINESS),
        variables: {"businessId": businessId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      return false;
    }
    return true;
  }

  Future<bool> unlikeBusiness(String businessId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(LIKE_BUSINESS),
        variables: {"businessId": businessId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    return true;
  }

  Future<PopUp> getPopUp({String category}) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_POP_UP),
        variables: {"category": category},
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['popUpOne'];
    print(data);
    return new PopUp.fromJson(data);
  }
}
