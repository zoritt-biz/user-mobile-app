import 'package:flutter/material.dart';

@immutable
class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final String link;
  final String video;
  final String photos;

  Event({
    this.id,
    this.title,
    this.description,
    this.location,
    this.link,
    this.video,
    this.photos,
  });
}
