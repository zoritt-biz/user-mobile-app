import 'package:flutter/material.dart';

@immutable
class Post {
  final String id;
  final String description;
  final List<String> video;
  final List<String> photos;
  final String businessLogo;
  final String businessName;

  Post({
    this.id,
    this.description,
    this.video,
    this.photos,
    this.businessLogo,
    this.businessName,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      id: data['_id'],
      description: data['description'],
      photos: (data['photos'] as List).map((e) => e.toString()).toList(),
      businessName: data['owner']['businessName'],
      businessLogo: data['owner']['logoPics'],
    );
  }
}
