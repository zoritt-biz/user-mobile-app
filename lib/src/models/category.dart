import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  Category({
    this.id,
    this.name,
    this.parent,
    this.image,
    this.autocompleteTerm,
  });

  final String id;
  final String name;
  final String parent;
  final String image;
  final String autocompleteTerm;

  @override
  List<Object> get props => [id, name, parent, autocompleteTerm];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      parent: json['parent'],
      image: json['image'],
      autocompleteTerm: json['autocompleteTerm'],
    );
  }
}
