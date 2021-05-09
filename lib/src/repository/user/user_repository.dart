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
        userType: data['userType']);
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
    return data.map((e) {
      e['isInterested'] = true;
      return Events.fromJson(e);
    }).toList();
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
    return data.map((e) {
      e['isLiked'] = true;
      return Post.fromJson(e);
    }).toList();
  }
}
