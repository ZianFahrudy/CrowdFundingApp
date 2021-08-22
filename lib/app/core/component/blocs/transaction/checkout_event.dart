part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class OnCheckoutEvent extends CheckoutEvent {
  final CheckoutBody body;
  OnCheckoutEvent(this.body);
}
