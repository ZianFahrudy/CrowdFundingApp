import 'package:crowd_funding/app/core/component/domain/models/response/login_model.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/login_body.dart';

abstract class UserRepository {
  Stream<Either<Failure, LoginModel>> login(LoginBody body);
}
