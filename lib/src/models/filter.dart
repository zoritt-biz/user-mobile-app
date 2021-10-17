import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Filter extends Equatable {
  Filter({
    this.query = "",
    this.distance = 0,
    this.lng = 0.0,
    this.lat = 0.0,
    this.openNow = false,
    this.category = const [],
  });

  final String query;
  final double distance;
  final double lng;
  final double lat;
  final bool openNow;
  final List<String> category;

  @override
  List<Object> get props => [query, distance, openNow, category];
}
