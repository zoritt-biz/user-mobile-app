import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/mutations/mutations.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class UserRepository {
  final GraphQLClient client;

  UserRepository({@required this.client}) : assert(client != null);

  Future<User> userCreate(User user) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(CREATE_USER),
        variables: {
          "fullName": user.fullName,
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
      return User(id: data['_id']);
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
    return User(
      id: data['_id'],
      fullName: data['fullName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      firebaseId: data['firebaseId'],
      userType: data['userType'],
      businesses:
          (data['businesses'] as List).map((e) => e['_id'].toString()).toList(),
    );
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
    return User(
      id: data['_id'],
      fullName: data['fullName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      firebaseId: data['firebaseId'],
      userType: data['userType'],
      events: (data['interestedInEvents'] as List).length > 0 ? (data['interestedInEvents'] as List).map(
        (e) => Events(
          businessName: e['owner']['businessName'],
          description: e['description'],
          title: e['title'],
          location: e['location'],
          link: e['link'],
        ),
      ) : [],
      posts: (data['likedPosts'] as List).length > 0 ? (data['likedPosts'] as List).map(
        (e) => Post(
          businessName: e['owner']['businessName'],
          businessLogo: e['owner']['logoPics'],
          description: e['description'],
          photos: e['photos'],
        ),
      ) : [],
    );
  }
}
