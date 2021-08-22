import 'package:crowd_funding/app/core/constants/constant.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModuleInjectable {
  @lazySingleton
  Dio get dio {
    BaseOptions options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: {"Content-Type": "application/json"},
        receiveDataWhenStatusError: true);
    return Dio(options);
  }
}
