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
  final List<String> emails;
  final String website;
  final String logoPic;
  final List<String> pictures;
  final String slogan;
  final String description;
  final String specialization;
  final List<String> searchIndex;
  final String history;
  final String establishedIn;
  final String subscription;
  final List<OpenHours> openHours;
  final List<Events> events;
  final List<Post> posts;
  final List<Category> categories;

  Business({
    this.id,
    this.businessName,
    this.phoneNumber,
    this.location,
    this.emails,
    this.website,
    this.logoPic,
    this.pictures,
    this.slogan,
    this.description,
    this.specialization,
    this.searchIndex,
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

  factory Business.fromJson(Map<String, dynamic> data) {
    return Business(
      id: data['_id'],
      businessName: data['businessName'],
      phoneNumber: (data['phoneNumber'] as List).map((e) => e.toString()).toList(),
      location: data['location'],
      emails: (data['emails'] as List) != null ? (data['emails'] as List).length > 0 ? (data['emails'] as List).map((e) => e.toString()).toList() : [] : [],
      website: data['website'],
      logoPic: data['logoPics'],
      slogan: data['slogan'],
      description: data['description'],
      specialization: data['specialization'],
      searchIndex: (data['searchIndex']as List) != null ? (data['searchIndex'] as List).length > 0
          ? (data['searchIndex'] as List).map((e) => e.toString()).toList()
          : [] : [],
      history: data['history'],
      establishedIn: data['establishedIn'],
      subscription: data['subscription'],
      pictures: (data['pictures'] as List).map((e) => e.toString()).toList(),
      openHours: (data['openHours']as List) != null ? (data['openHours'] as List).length > 0 ? (data['openHours'] as List)
          .map((e) =>
              OpenHours(closes: e['closes'], day: e['day'], opens: e['opens']))
          .toList() : [] : [],
      posts: (data['posts']as List) != null ? (data['posts'] as List).length > 0 ? (data['posts'] as List)
          .map((e) => Post(
                id: e['_id'],
                description: e['description'],
                video: (e['videos'] as List).map((e) => e.toString()).toList(),
                photos: (e['photos'] as List).map((e) => e.toString()).toList(),
              ))
          .toList() : [] : [],
      events: (data['events']as List) != null ? (data['events'] as List).length > 0 ? (data['events'] as List)
          .map((e) => Events(
                id: e['_id'],
                description: e['description'],
                title: e['title'],
                link: e['link'],
                location: e['location'],
                video: (e['videos'] as List).map((e) => e.toString()).toList(),
                photos: (e['photos'] as List).map((e) => e.toString()).toList(),
              ))
          .toList() : [] : [],
      categories: (data['categories']as List) != null ? (data['categories'] as List).length > 0 ? (data['categories'] as List)
          .map((e) => Category(
                id: e['_id'],
                autocompleteTerm: e['autocompleteTerm'],
                name: e['name'],
                parent: e['parent'],
              ))
          .toList() : [] : [],
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
