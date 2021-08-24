import 'package:crowd_funding/app/core/component/domain/models/request/register_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/default_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/upload_avatar_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';
import 'package:crowd_funding/app/core/component/domain/repository/user/user_repository.dart';
import 'package:crowd_funding/app/core/constants/apipath.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  Dio _dio;

  UserRepositoryImpl(this._dio);

  final storage = GetStorage();

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

  @override
  Stream<Either<Failure, LoginModel>> getUserData() async* {
    Response response;
    try {
      response = await _dio.get(ApiPath.users,
          options: Options(headers: {
            'Authorization': 'Bearer ${storage.read(KeyConstant.token)}'
          }));
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

  @override
  Stream<Either<Failure, DefaultModel>> uploadAvatar(
      UploadAvatarBody body) async* {
    Response response;
    try {
      FormData formData = FormData.fromMap(
          {'avatar': await MultipartFile.fromFile(body.avatar!)});
      response = await _dio.post(ApiPath.avatar,
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer ${storage.read(KeyConstant.token)}",
            "Content-Type": "multipart/form-data"
          }));
      var data = DefaultModel.fromJson(response.data);
      yield right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        yield left(errorResult);
      }
      yield left(Failure("Something error"));
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, LoginModel>> register(RegisterBody body) async* {
    Response response;
    try {
      response = await _dio.post(ApiPath.register, data: body.toJson());
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
