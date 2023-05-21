import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/category.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

class Business extends Equatable {
  final String id;
  final String businessName;
  final List<String> phoneNumbers;
  final String location;
  final String locationDescription;
  final double lat;
  final double lng;
  final double distance;
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
  final String state;
  final List<OpenHours> openHours;
  final List<String> branches;
  final List<String> menus;
  final List<Events> events;
  final List<Post> posts;
  final List<Category> categories;
  bool isLiked;

  Business({
    this.id,
    this.businessName,
    this.phoneNumbers,
    this.location,
    this.locationDescription,
    this.lat,
    this.lng,
    this.distance,
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
    this.branches,
    this.menus,
    this.events,
    this.posts,
    this.categories,
    this.isLiked,
    this.state,
  });

  @override
  List<Object> get props =>
      [id, businessName, description, phoneNumbers, location];

  factory Business.fromJson(Map<String, dynamic> data) {
    return Business(
      id: data['_id'],
      businessName: data['businessName'],
      phoneNumbers: (data['phoneNumbers'] as List) != null
          ? (data['phoneNumbers'] as List).map((e) => e.toString()).toList()
          : [],
      location: data['location'],
      locationDescription: data['locationDescription'] != null
          ? data['locationDescription']
          : data['location'],
      distance: data['distance'],
      emails: (data['emails'] as List) != null
          ? (data['emails'] as List).map((e) => e.toString()).toList()
          : [],
      website: data['website'],
      logoPic: data['logoPics'],
      slogan: data['slogan'],
      lat: data['lngLat']['coordinates'][1],
      lng: data['lngLat']['coordinates'][0],
      description: data['description'],
      specialization: data['specialization'],
      history: data['history'],
      establishedIn: data['establishedIn'],
      subscription: data['subscription'],
      state: data['state'],
      isLiked: data['isLiked'] != null ? data["isLiked"] : false,
      pictures: (data['pictures'] as List) != null
          ? (data['pictures'] as List).map((e) => e.toString()).toList()
          : [""],
      openHours: (data['openHours'] as List) != null
          ? (data['openHours'] as List)
              .map((e) => OpenHours(
                  closes: e['closes'],
                  day: e['day'],
                  opens: e['opens'],
                  isOpen: e['isOpen']))
              .toList()
          : [],
      posts: (data['posts'] as List) != null
          ? (data['posts'] as List).map((e) => Post.fromJson(e)).toList()
          : [],
      events: (data['events'] as List) != null
          ? (data['events'] as List).map((e) => Events.fromJson(e)).toList()
          : [],
      categories: (data['categories'] as List) != null
          ? (data['categories'] as List)
              .map((e) => Category(
                    id: e['_id'],
                    autocompleteTerm: e['autocompleteTerm'],
                    name: e['name'],
                    parent: e['parent'],
                  ))
              .toList()
          : [],
      menus: (data['menu'] as List) != null
          ? (data['menu'] as List).map((e) => e['_id'].toString()).toList()
          : [],
      branches: (data['branches'] as List) != null
          ? (data['branches'] as List).map((e) => e['_id'].toString()).toList()
          : [],
    );
  }

  @override
  String toString() => 'Business { id: $id, businessName: $businessName}';
}

@immutable
class OpenHours {
  final String day;
  final bool isOpen;
  final String opens;
  final String closes;

  OpenHours({this.day, this.opens, this.closes, this.isOpen});
}
