part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutException extends CheckoutState {}

class CheckoutFailure extends CheckoutState {
  final String error;
  CheckoutFailure(this.error);
}

class CheckoutSuccess extends CheckoutState {
  final CheckoutModel transactions;

  CheckoutSuccess(this.transactions);
}
