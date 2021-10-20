import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class BusinessList extends Equatable {
  final String id;
  final String autocompleteTerm;

  BusinessList({
    this.id,
    this.autocompleteTerm,
  });

  @override
  List<Object> get props => [id, autocompleteTerm];

  factory BusinessList.fromJson(Map<String, dynamic> data) {
    return BusinessList(
      id: data['_id'],
      autocompleteTerm: data['autocompleteTerm'],
    );
  }

  @override
  String toString() => 'Business { id: $id, businessName: $autocompleteTerm }';
}
