import 'package:crowd_funding/app/core/component/domain/models/request/upload_avatar_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/default_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/register_body.dart';

abstract class UserRepository {
  Stream<Either<Failure, LoginModel>> login(LoginBody body);
  Stream<Either<Failure, LoginModel>> register(RegisterBody body);
  Stream<Either<Failure, LoginModel>> getUserData();
  Stream<Either<Failure, DefaultModel>> uploadAvatar(UploadAvatarBody body);
}
