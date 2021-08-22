import 'package:crowd_funding/app/core/component/domain/models/response/checkout_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/checkout_body.dart';
import 'package:crowd_funding/app/core/component/domain/repository/transaction/transaction_repository.dart';
import 'package:crowd_funding/app/core/constants/apipath.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  Dio _dio;
  TransactionRepositoryImpl(this._dio);
  @override
  Stream<Either<Failure, CheckoutModel>> checkout(CheckoutBody body) async* {
    Response response;
    try {
      response = await _dio.post(ApiPath.checkout, data: body.toJson());
      var data = CheckoutModel.fromJson(response.data);
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
