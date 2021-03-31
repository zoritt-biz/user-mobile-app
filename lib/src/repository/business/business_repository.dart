import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class BusinessRepository {
  final GraphQLClient client;
  final FirebaseStorage firebaseStorage;

  BusinessRepository({
    @required this.client,
    @required this.firebaseStorage,
  }) : assert(GraphQLClient != null && FirebaseStorage != null);

  Future<Business> createBusiness(Business business, File file) async {
    String fileName = file.path.substring(file.path.lastIndexOf("/"));
    try {
      await firebaseStorage
          .ref("${business.businessName}/$fileName")
          .putFile(file);

      String downloadURL = await firebaseStorage
          .ref("${business.businessName}/$fileName")
          .getDownloadURL();

      final results = await client.mutate(
        MutationOptions(
          document: gql(CREATE_BUSINESS),
          variables: {
            'businessName': business.businessName,
            'phoneNumber': business.phoneNumber,
            'location': business.location,
            'description': business.description,
            'picture': [downloadURL],
          },
        ),
      );
      if (results.hasException) {
        throw results.exception;
      } else {
        final data = results.data['businessCreateOne']['record'];
        return Business(
          id: data['_id'],
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Business> getBusiness(String id) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_BUSINESS),
        variables: {"id": id},
      ),
    );

    if (result.hasException) {
      print(result.hasException);
      throw result.exception;
    }

    final data = result.data['businessById'];

    return new Business.fromJson(data);
  }

  Future<Business> updateBusiness(Business business) async {
    return business;
  }

  Future<Business> createEvent(
    File file,
    Business business,
    Events events,
  ) async {
    String fileName = file.path.substring(file.path.lastIndexOf("/"));
    try {
      await firebaseStorage
          .ref("${business.id}/events/$fileName")
          .putFile(file);

      String downloadURL = await firebaseStorage
          .ref("${business.id}/events/$fileName")
          .getDownloadURL();

      final results = await client.mutate(
        MutationOptions(
          document: gql(CREATE_EVENT),
          variables: {
            "title": events.title,
            "description": events.description,
            "location": events.location,
            "link": events.link,
            "videos": [""],
            "photos": [downloadURL]
          },
        ),
      );
      if (results.hasException) {
        throw results.exception;
      } else {
        final data = results.data['eventCreateOne']['record'];
        String id = data['_id'];

        final result = await client.mutate(
          MutationOptions(
            document: gql(ADD_EVENT),
            variables: {
              "businessId": business.id,
              "events": [...business.events.map((e) => e.id.toString()), id]
            },
          ),
        );
        if (result.hasException) {
          print(result.exception);
          throw result.exception;
        }

        final bizData = result.data['businessUpdateById']['record'];

        return new Business.fromJson(bizData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Business> createPost(File file, Business business, Post post) async {
    String fileName = file.path.substring(file.path.lastIndexOf("/"));
    try {
      await firebaseStorage.ref("${business.id}/posts/$fileName").putFile(file);

      String downloadURL = await firebaseStorage
          .ref("${business.id}/posts/$fileName")
          .getDownloadURL();

      final results = await client.mutate(
        MutationOptions(
          document: gql(CREATE_POST),
          variables: {
            "description": post.description,
            "videos": [""],
            "photos": [downloadURL]
          },
        ),
      );
      if (results.hasException) {
        throw results.exception;
      } else {
        final data = results.data['postCreateOne']['record'];
        String id = data['_id'];

        final result = await client.mutate(
          MutationOptions(
            document: gql(ADD_POST),
            variables: {
              "businessId": business.id,
              "posts": [...business.posts.map((e) => e.id.toString()), id]
            },
          ),
        );

        if (result.hasException) {
          throw result.exception;
        }

        final bizData = result.data['businessUpdateById']['record'];

        return new Business.fromJson(bizData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Business> updateDescription(String id, String description) async {
    final results = await client.mutate(
      MutationOptions(
        document: gql(UPDATE_DESCRIPTION),
        variables: {
          "businessId": id,
          "description": description,
        },
      ),
    );

    if (results.hasException) {
      throw results.exception;
    }

    final data = results.data['businessUpdateById']['record'];

    return new Business.fromJson(data);
  }

  Future<Business> updateSpecialization(
    String id,
    String specialization,
  ) async {
    print(id);
    print(specialization);
    final results = await client.mutate(
      MutationOptions(
        document: gql(UPDATE_SPECIALIZATION),
        variables: {
          "businessId": id,
          "specialization": specialization,
        },
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }

    final data = results.data['businessUpdateById']['record'];

    return new Business.fromJson(data);
  }

  Future<Business> updateHistory(
    String id,
    String history,
    String establishedIn,
  ) async {
    final results = await client.mutate(
      MutationOptions(
        document: gql(UPDATE_HISTORY),
        variables: {
          "businessId": id,
          "history": history,
          "establishedIn": establishedIn,
        },
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }

    final data = results.data['businessUpdateById']['record'];

    return new Business.fromJson(data);
  }

  Future<Business> updateAddressInfo(
      String id,
      Business business,
      ) async {
    final results = await client.mutate(
      MutationOptions(
        document: gql(UPDATE_ADDRESS_INFO),
        variables: {
          "businessId": id,
          "emails": business.emails,
          "phoneNumbers": business.phoneNumber,
          "website": business.website,
        },
      ),
    );
    if (results.hasException) {
      throw results.exception;
    }

    final data = results.data['businessUpdateById']['record'];

    return new Business.fromJson(data);
  }

  Future<void> deleteBusiness(String id) async {}
}
