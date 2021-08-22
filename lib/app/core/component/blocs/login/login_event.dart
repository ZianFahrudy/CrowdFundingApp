part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final LoginBody body;

  OnLoginEvent(this.body);
}
