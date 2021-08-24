part of 'upload_avatar_bloc.dart';

@immutable
abstract class UploadAvatarState {}

class UploadAvatarInitial extends UploadAvatarState {}

class UploadAvatarLoading extends UploadAvatarState {}

class UploadAvatarFailure extends UploadAvatarState {
  final String error;
  UploadAvatarFailure(this.error);
}

class UploadAvatarSuccess extends UploadAvatarState {}
