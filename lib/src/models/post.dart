import 'package:flutter/material.dart';

@immutable
class Post {
  final String id;
  final String description;
  final String video;
  final String photos;

  Post({this.id, this.description, this.video, this.photos});
}
