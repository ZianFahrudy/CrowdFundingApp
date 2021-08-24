part of 'upload_avatar_bloc.dart';

@immutable
abstract class UploadAvatarEvent {}

class OnUploadAvatar extends UploadAvatarEvent {
  final UploadAvatarBody body;

  OnUploadAvatar(this.body);
}
