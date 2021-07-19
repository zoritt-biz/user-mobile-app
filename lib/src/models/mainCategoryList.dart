import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MainCategoryList extends Equatable {
  MainCategoryList({
    this.id,
    this.name,
    this.image,
    this.subCategories,
  });

  final String id;
  final String name;
  final String image;
  final List<String> subCategories;

  @override
  List<Object> get props => [id, name, subCategories];

  factory MainCategoryList.fromJson(Map<String, dynamic> json) {
    return MainCategoryList(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      subCategories:
          (json['sub_categories'] as List).map((e) => e.toString()).toList(),
    );
  }
}
