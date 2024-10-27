// login_event.dart
import 'package:equatable/equatable.dart';//Equatable es una clase que nos permite comparar objetos de una manera más sencilla.

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}


