import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository) : super(LoginInitial());

  UserRepository _repository;

  final storage = GetStorage();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginEvent) {
      yield LoginLoading();

      final response = _repository.login(event.body);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield LoginFailure(l.error);
        }, (value) async* {
          storage.write(KeyConstant.token, value.data!.token);
          storage.write(KeyConstant.userId, value.data!.id);
          yield LoginSuccess();
        });
      }
    }
  }
}
