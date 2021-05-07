import 'package:flutter/material.dart';

@immutable
class Events {
  final String id;
  final String title;
  final String description;
  final String location;
  final String link;
  final bool isInterested;
  final List<String> video;
  final List<String> photos;
  final String logoPics;
  final String businessName;

  Events({
    this.id,
    this.title,
    this.description,
    this.location,
    this.link,
    this.video,
    this.photos,
    this.logoPics,
    this.isInterested,
    this.businessName,
  });

  factory Events.fromJson(Map<String, dynamic> data) {
    return Events(
      title: data["title"],
      description: data["description"],
      location: data["location"],
      link: data["link"],
      id: data["_id"],
      isInterested: data["isInterested"],
      logoPics: data["owner"] != null
          ? data["owner"]["logoPics"] != null
              ? data["owner"]["logoPics"]
              : ""
          : "",
      photos: (data['photos'] as List).map((e) => e.toString()).toList(),
      businessName: data["owner"] != null ? data["owner"]["businessName"] : "",
    );
  }
}
