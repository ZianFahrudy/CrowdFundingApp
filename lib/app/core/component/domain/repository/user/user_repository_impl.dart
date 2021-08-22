import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:crowd_funding/app/core/constants/apipath.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  Dio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Stream<Either<Failure, LoginModel>> login(LoginBody body) async* {
    Response response;
    try {
      response = await _dio.post(ApiPath.login, data: body.toJson());
      var data = LoginModel.fromJson(response.data);
      print("RESPONSE => ${response.data}");
      yield right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);
        yield left(errorResult);
      }
      yield left(Failure("Something error bro"));
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }
}
