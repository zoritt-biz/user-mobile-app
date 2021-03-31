import 'package:flutter/material.dart';

@immutable
class Post {
  final String id;
  final String description;
  final List<String> video;
  final List<String> photos;

  Post({this.id, this.description, this.video, this.photos});

  // factory Post.fromJson(Map<String, dynamic> data) {
  //   return;
  // }
}
