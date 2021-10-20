import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class UserRepository {
  final GraphQLClient client;
  final FlutterSecureStorage storage;
  final FirebaseStorage firebaseStorage;

  UserRepository({
    @required this.client,
    @required this.storage,
    @required this.firebaseStorage,
  }) : assert(client != null && storage != null && firebaseStorage != null);

  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {
    final result = await client.query(
      QueryOptions(
        document: gql(SIGN_IN),
        variables: {"email": email, "password": password},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['signIn'];
    User user = new User.fromJson(data['user']);
    user.token = data['accessToken'];
    return user;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "jwt");
    return;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: "jwt", value: token);
    return;
  }

  Future<String> hasToken() async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return null;
    return jwt;
  }

  Future<User> getUser() async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );
    if (result.hasException) {
      return null;
    }
    final data = result.data['user'];
    return new User.fromJson(data);
  }

  Future<User> signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String middleName,
    @required String lastName,
    @required String phoneNumber,
  }) async {
    assert(email != null &&
        password != null &&
        firstName != null &&
        middleName != null &&
        lastName != null &&
        phoneNumber != null);
    final result = await client.query(
      QueryOptions(
        document: gql(SIGN_UP),
        variables: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "middleName": middleName,
          "lastName": lastName,
          "phoneNumber": phoneNumber,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      print(result.exception);
      throw result.exception.graphqlErrors.first.message;
    }
    final data = result.data['userSignUp'];
    User user = new User.fromJson(data['user']);
    user.token = data['accessToken'];
    return user;
  }

  Future<List<Events>> getUserEvents() async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER_EVENTS),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['user']['interestedInEvents'] as List;
    return data.map((e) => Events.fromJson(e)).toList();
  }

  Future<List<Post>> getUserPosts() async {
    final result = await client.query(
      QueryOptions(
        document: gql(GET_USER_POSTS),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['user']['likedPosts'] as List;
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
          variables: {"id": user.id, "image": downloadUrl},
        ),
      );
      if (results.hasException) {
        throw results.exception;
      }
      final data = results.data['userUpdateById']['record'];
      return new User.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
