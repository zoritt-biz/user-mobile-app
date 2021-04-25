import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

class User extends Equatable {
  final String id;
  final String firebaseId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String userType;
  final List<String> businesses;
  final List<Events> events;
  final List<Post> posts;

  User({
    this.id,
    this.firebaseId,
    this.fullName,
    this.email,
    this.password,
    this.userType,
    this.businesses,
    this.phoneNumber,
    this.events,
    this.posts,
  });

  @override
  List<Object> get props => [
        id,
        firebaseId,
        fullName,
        email,
        password,
        phoneNumber,
        userType,
        businesses
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firebaseId: json['firebaseId'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      userType: json['userType'],
      businesses: json['businesses'],
    );
  }

  @override
  String toString() => '''User { 
          id: $id, 
          firebaseId: $firebaseId, 
          fullName: $fullName, 
          phoneNumber: $phoneNumber, 
          email: $email, 
          password: $password, 
          userType: $userType, 
          businesses: $businesses 
        }''';
}
