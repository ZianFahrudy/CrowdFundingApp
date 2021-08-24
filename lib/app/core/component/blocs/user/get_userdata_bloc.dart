import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetUserDataBloc {
  UserRepository _repository;
  GetUserDataBloc(this._repository);

  final _userData = BehaviorSubject<LoginModel>();

  Function(LoginModel) get updateUserData => _userData.sink.add;
  Stream<LoginModel> get data => _userData.stream;

  fetchUserData() {
    final result = _repository.getUserData();

    result.listen((event) {
      event.fold((error) {
        print("Something error when request user data $error");

        return _userData.addError(error);
      }, (value) => updateUserData(value));
    });
  }

  dispose() {
    _userData.close();
  }
}
