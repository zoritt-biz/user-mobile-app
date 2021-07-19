import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class UserRepository {
  final GraphQLClient client;
  final FirebaseStorage firebaseStorage;

  UserRepository({
    @required this.client,
    @required this.firebaseStorage,
  }) : assert(client != null && firebaseStorage != null);

  Future<User> userCreate(User user) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(CREATE_USER),
        variables: {
          "firstName": user.firstName,
          "lastName": user.lastName,
          "userType": "Normal",
          "email": user.email,
          "phoneNumber": user.phoneNumber,
          "firebaseId": user.firebaseId
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    } else {
      final data = result.data['userCreateOne']['record'];
      return User.fromJson(data);
    }
  }

  Future<User> getUser(String firebaseId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER),
        variables: {
          'firebaseId': firebaseId,
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['userOne'];
    return User.fromJson(data);
  }

  Future<User> getUserProfile(String firebaseId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER_PROFILE),
        variables: {
          'firebaseId': firebaseId,
        },
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['userOne'];
    return User.fromJson(data);
  }

  Future<List<Events>> getUserEvents(String firebaseId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER_EVENTS),
        variables: {
          'firebaseId': firebaseId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['userOne']['interestedInEvents'] as List;
    if (data.length == 0) {
      return [];
    }
    return data.map((e) => Events.fromJson(e)).toList();
  }

  Future<List<Post>> getUserPosts(String firebaseId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER_POSTS),
        variables: {
          'firebaseId': firebaseId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['userOne']['likedPosts'] as List;
    if (data.length == 0) {
      return [];
    }
    return data.map((e) => Post.fromJson(e)).toList();
  }

  UploadTask uploadPicture(File file, User user, String dirName) {
    try {
      String fileName = file.path.substring(file.path.lastIndexOf("/"));
      UploadTask uploadTask =
          firebaseStorage.ref("${user.email}/$dirName/$fileName").putFile(file);
      return uploadTask;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<String> getDownloadUrl(File file, User user, String dirName) async {
    String fileName = file.path.substring(file.path.lastIndexOf("/"));
    return await firebaseStorage
        .ref("${user.email}/$dirName/$fileName")
        .getDownloadURL();
  }

  Future<User> addProfilePic(
    File file,
    User user,
    String downloadUrl,
  ) async {
    try {
      print(user.id);
      final results = await client.mutate(
        MutationOptions(
          document: gql(USER_ADD_LOGO),
          variables: {
            "id": user.id,
            "image": downloadUrl,
          },
        ),
      );
      if (results.hasException) {
        print(results.exception);
        throw results.exception;
      }
      final data = results.data['userUpdateById']['record'];
      return new User.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
