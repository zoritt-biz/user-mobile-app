import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Location extends Equatable {
  final String placeId;
  final String description;

  Location({
    this.placeId,
    this.description,
  });

  @override
  List<Object> get props => [placeId, description];

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(
      placeId: data['place_id'],
      description: data['description'],
    );
  }

  @override
  String toString() => 'Location { id: $placeId, description: $description }';
}
