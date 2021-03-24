import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/category.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

@immutable
class Business extends Equatable {
  final String id;
  final String businessName;
  final List<String> phoneNumber;
  final String location;
  final String emails;
  final String website;
  final String logoPics;
  final List<Photo> pictures;
  final String slogan;
  final String description;
  final String specialization;
  final String history;
  final String establishedIn;
  final String subscription;
  final List<OpenHours> openHours;
  final List<Event> events;
  final List<Post> posts;
  final List<Category> categories;

  Business({
    this.id,
    this.businessName,
    this.phoneNumber,
    this.location,
    this.emails,
    this.website,
    this.logoPics,
    this.pictures,
    this.slogan,
    this.description,
    this.specialization,
    this.history,
    this.establishedIn,
    this.subscription,
    this.openHours,
    this.events,
    this.posts,
    this.categories,
  });

  @override
  List<Object> get props =>
      [id, businessName, description, phoneNumber, location];

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      businessName: json['businessName'],
      description: json['description'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
    );
  }

  @override
  String toString() =>
      'Business { id: $id, businessName: $businessName, description: $description, phoneNumber: $phoneNumber, location: $location }';
}

@immutable
class OpenHours {
  final String day;
  final String opens;
  final String closes;

  OpenHours({this.day, this.opens, this.closes});
}

@immutable
class Photo {
  final String photo;
  final String caption;
  final int numOfLikes;

  Photo({this.photo, this.caption, this.numOfLikes});
}
