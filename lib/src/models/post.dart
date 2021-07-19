import 'package:flutter/material.dart';

@immutable
class Post {
  final String id;
  final String description;
  final List<String> videos;
  final List<String> photos;
  final String owner;
  final String businessName;
  final String businessLogo;
  bool isLiked;

  Post({
    this.id,
    this.description,
    this.videos,
    this.photos,
    this.owner,
    this.businessName,
    this.businessLogo,
    this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      id: data['_id'],
      description: data['description'],
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
      isLiked: data["isLiked"] != null ? data["isLiked"] : false,
    );
  }
}
