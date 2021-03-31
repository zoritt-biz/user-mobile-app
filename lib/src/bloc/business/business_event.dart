part of 'business_bloc.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();
}

class BusinessLoad extends BusinessEvent {
  final String id;

  const BusinessLoad(this.id);

  @override
  List<Object> get props => [];
}

class BusinessCreate extends BusinessEvent {
  final Business business;
  final File photo;

  const BusinessCreate(this.business, this.photo);

  @override
  List<Object> get props => [business];

  @override
  String toString() => 'business Created {business: $business}';
}

class BusinessUpdate extends BusinessEvent {
  final Business business;
  final String field;
  final File file;
  final Events events;
  final Post post;

  const BusinessUpdate({
    this.business,
    this.field,
    this.file,
    this.events,
    this.post,
  });

  @override
  List<Object> get props => [business];

  @override
  String toString() => 'business Updated {business: $business}';
}

class BusinessDelete extends BusinessEvent {
  final String id;

  const BusinessDelete(this.id);

  @override
  List<Object> get props => [];

  @override
  toString() => 'business Deleted {business: $id}';
}
