import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MenuList extends Equatable {
  final String id;
  final String image;
  final String name;
  final String price;
  final String discount;
  final String description;

  MenuList({
    this.id,
    this.image,
    this.name,
    this.price,
    this.discount,
    this.description,
  });

  @override
  List<Object> get props => [id, image, name, price, description, discount];
}

@immutable
class Menu extends Equatable {
  final String id;
  final String category;
  final List<MenuList> menuList;

  Menu({
    this.id,
    this.category,
    this.menuList,
  });

  @override
  List<Object> get props => [id, category, menuList];

  factory Menu.fromJson(Map<String, dynamic> data) {
    return Menu(
      id: data['_id'],
      category: data['category'],
      menuList: (data['menuList'] as List) != null
          ? (data['menuList'] as List)
              .map((e) => MenuList(
                    id: e['_id'].toString(),
                    name: e['name'],
                    price: e['price'],
                    discount: e['discount'],
                    description: e['description'],
                  ))
              .toList()
          : [],
    );
  }

  @override
  String toString() => 'Menu { category: $category }';
}
