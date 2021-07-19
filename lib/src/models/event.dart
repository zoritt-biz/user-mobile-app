import 'package:flutter/material.dart';

@immutable
class Events {
  final String id;
  final String title;
  final String description;
  final String location;
  final String link;
  final List<String> videos;
  final List<String> photos;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String owner;
  final String businessName;
  final String businessLogo;
  bool isInterested;

  Events({
    this.id,
    this.title,
    this.description,
    this.location,
    this.link,
    this.videos,
    this.photos,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.owner,
    this.businessName,
    this.businessLogo,
    this.isInterested,
  });

  factory Events.fromJson(Map<String, dynamic> data) {
    return Events(
      id: data['_id'],
      location: data['location'],
      description: data['description'],
      title: data['title'],
      link: data['link'],
      endDate: data['endDate'],
      startDate: data['startDate'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      videos: (data['videos'] as List) != null
          ? (data['videos'] as List).map((e) => e.toString()).toList()
          : [],
      photos: (data['photos'] as List) != null
          ? (data['photos'] as List).map((e) => e.toString()).toList()
          : [],
      owner: data["owner"] != null ? data["owner"]['_id'] : "",
      businessName: data["owner"] != null ? data["owner"]['businessName'] : "",
      businessLogo: data["owner"] != null
          ? data["owner"]['logoPics'] != null
              ? data["owner"]['logoPics']
              : ""
          : "",
      isInterested: data["isInterested"] != null ? data["isInterested"] : false,
    );
  }
}
