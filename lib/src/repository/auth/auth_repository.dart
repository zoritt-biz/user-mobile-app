import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/auth-mutations.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart' as user_model;
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;
  final GraphQLClient client;

  AuthenticationRepository(
      {@required this.client, this.firebaseAuth, this.userRepository});

  Stream<user_model.User> get user {
    return firebaseAuth.authStateChanges().map(
      (user) {
        return user == null
            ? null
            : user_model.User(email: user.email, firebaseId: user.uid);
      },
    );
  }

  Future<String> login(String email, String password) async {
    final result = await client.query(
      QueryOptions(
        document: gql(SIGN_IN),
        variables: {
          "email": email,
          "password": password,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['accessToken'];
    return data;
  }

  Future<user_model.User> signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
  }) async {
    assert(email != null &&
        password != null &&
        firstName != null &&
        lastName != null &&
        phoneNumber != null);
    try {
      final userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final newUser = await userRepository.userCreate(user_model.User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        firebaseId: userCredentials.user.uid,
        phoneNumber: phoneNumber,
      ));

      return newUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<user_model.User> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      user_model.User newUser;
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        newUser = await userRepository.getUser(value.user.uid);
      });

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
