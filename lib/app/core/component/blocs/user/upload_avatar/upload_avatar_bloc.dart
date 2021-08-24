import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/upload_avatar_body.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'upload_avatar_event.dart';
part 'upload_avatar_state.dart';

@injectable
class UploadAvatarBloc extends Bloc<UploadAvatarEvent, UploadAvatarState> {
  UploadAvatarBloc(this._repository) : super(UploadAvatarInitial());

  UserRepository _repository;

  @override
  Stream<UploadAvatarState> mapEventToState(
    UploadAvatarEvent event,
  ) async* {
    if (event is OnUploadAvatar) {
      yield UploadAvatarLoading();

      final response = _repository.uploadAvatar(event.body);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield UploadAvatarFailure(l.error);
        }, (value) async* {
          yield UploadAvatarSuccess();
        });
      }
    }
  }
}
