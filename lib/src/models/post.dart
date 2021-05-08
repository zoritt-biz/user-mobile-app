import 'package:flutter/material.dart';

@immutable
class Post {
  final String id;
  final String description;
  final List<String> video;
  final List<String> photos;
  final bool isLiked;
  final String businessLogo;
  final String businessName;

  Post({
    this.id,
    this.description,
    this.video,
    this.photos,
    this.isLiked,
    this.businessLogo,
    this.businessName,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      id: data['_id'],
      description: data['description'],
      photos: (data['photos'] as List).map((e) => e.toString()).toList(),
      isLiked: data["isLiked"],
      businessName: data["owner"] != null ? data['owner']['businessName'] : "",
      businessLogo: data["owner"] != null
          ? data["owner"]["logoPics"] != null
              ? data["owner"]["logoPics"]
              : ""
          : "",
    );
  }
}
