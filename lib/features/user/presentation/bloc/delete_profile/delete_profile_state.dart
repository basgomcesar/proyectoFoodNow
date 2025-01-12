// login_state.dart
import 'package:equatable/equatable.dart';

abstract class DeleteProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteProfileStateInitial extends DeleteProfileState {
  
}

class DeleteProfileStateLoading extends DeleteProfileState {
}

class DeleteProfileStateSucess extends DeleteProfileState {
  
}

class DeleteProfileStateFailure extends DeleteProfileState {
  final String error;

  DeleteProfileStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}


//
class InvalidDataFailureState extends DeleteProfileState {
  final String error;
  InvalidDataFailureState({required this.error});
}

class UnauthorizedFailureState extends DeleteProfileState {
  final String error;
  UnauthorizedFailureState({required this.error});
}

class UserNotFoundFailureState extends DeleteProfileState {
  final String error;
  UserNotFoundFailureState({required this.error});
}

class ServerFailureState extends DeleteProfileState {
  final String error;
  ServerFailureState({required this.error});
}