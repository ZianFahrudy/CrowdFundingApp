import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/checkout_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/checkout_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/transaction/transaction_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

@injectable
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this._repository) : super(CheckoutInitial());
  TransactionRepository _repository;
  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is OnCheckoutEvent) {
      yield CheckoutLoading();

      final result = _repository.checkout(event.body);

      await for (final eventRes in result) {
        yield* eventRes.fold((l) async* {
          yield CheckoutFailure(l.error);
        }, (value) async* {
          yield CheckoutSuccess(value);
        });
      }
    }
  }
}
