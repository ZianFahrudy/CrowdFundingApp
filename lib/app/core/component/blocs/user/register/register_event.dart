part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class OnRegisterEvent extends RegisterEvent {
  final RegisterBody body;
  OnRegisterEvent(this.body);
}
