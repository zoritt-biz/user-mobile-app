import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/profile_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileBloc(this.userRepository) : super(ProfileUnknown());

  void getUserProfile(String id) async {
    emit(ProfileLoading());
    try {
      User user = await userRepository.getUserProfile(id);
      emit(ProfileLoadSuccessful(user));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }


  Future<void> addProfileImage(File file, User user) async {
    emit(ProfileLoading());
    UploadTask uploadTask = userRepository.uploadPicture(
      file,
      user,
      "profilePics",
    );

    await for (final event in uploadTask.snapshotEvents) {
      if (event.state == TaskState.success) {
        String downloadUrl = await userRepository.getDownloadUrl(file, user, "profilePics",);
        User item = await userRepository.addProfilePic(
          file,
          user,
          downloadUrl,
        );
        emit(ProfileLoadSuccessful(item));
      }
      if (event.state == TaskState.running) {
        double progress = ((event.bytesTransferred / event.totalBytes) * 100);
        emit(ProfileUpdating(progress: progress));
      }
    }
    try {
      await uploadTask;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
