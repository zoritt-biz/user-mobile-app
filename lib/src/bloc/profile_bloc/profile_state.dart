import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccessful extends ProfileState {
  final User user;

  ProfileLoadSuccessful({this.user});

  @override
  List<Object> get props => [user];
}

class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUnknown extends ProfileState {}
