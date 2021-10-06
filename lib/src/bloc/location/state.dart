import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/models/location.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoadSuccessful extends LocationState {
  final List<Location> location;

  LocationLoadSuccessful({this.location});

  @override
  List<Object> get props => [location];
}

class GeocodeLoadSuccessful extends LocationState {
  final LatLng latLng;

  GeocodeLoadSuccessful({this.latLng});

  @override
  List<Object> get props => [latLng];
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class LocationUnknown extends LocationState {}
