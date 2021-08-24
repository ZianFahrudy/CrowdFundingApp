import 'dart:async';
import 'package:crowd_funding/app/core/component/domain/models/request/register_body.dart';
import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._repository) : super(RegisterInitial());
  UserRepository _repository;

  final storage = GetStorage();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is OnRegisterEvent) {
      yield RegisterLoading();

      final response = _repository.register(event.body);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield RegisterFailure(l.error);
        }, (value) async* {
          storage.write(KeyConstant.token, value.data!.token);
          storage.write(KeyConstant.userId, value.data!.id);
          yield RegisterSuccess();
        });
      }
    }
  }
}
