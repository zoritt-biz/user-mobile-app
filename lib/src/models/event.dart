import 'package:flutter/material.dart';

@immutable
class Events {
  final String id;
  final String title;
  final String description;
  final String location;
  final String link;
  final List<String> video;
  final List<String> photos;

  Events({
    this.id,
    this.title,
    this.description,
    this.location,
    this.link,
    this.video,
    this.photos,
  });
}
