import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  Category({
    this.id,
    this.name,
    this.parent,
    this.autocompleteTerm,
  });

  final String id;
  final String name;
  final String parent;
  final String autocompleteTerm;

  @override
  List<Object> get props => [id, name, parent, autocompleteTerm];

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['ID'],
  //     name: json['name'],
  //     parent: json['parent'],
  //     autocompleteTerm: json['autocompleteTerm'],
  //   );
  // }

  @override
  String toString() =>
      'Category { id: $id, name: $name, parent: $parent, autocompleteTerm: $autocompleteTerm }';
}
