import 'package:crowd_funding/app/core/component/domain/models/request/checkout_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/checkout_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/transaction_list_model.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionRepository {
  Stream<Either<Failure, CheckoutModel>> checkout(CheckoutBody body);
  Stream<Either<Failure, TransactionListModel>> getTransactionList();
}
