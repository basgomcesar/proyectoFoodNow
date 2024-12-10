// login_state.dart
import 'package:equatable/equatable.dart';

abstract class EditProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProfileStateInitial extends EditProfileState {
  
}

class EditProfileStateLoading extends EditProfileState {
}

class EditProfileStateSucess extends EditProfileState {
  
}

class EditProfileStateFailure extends EditProfileState {
  final String error;

  EditProfileStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}


//
class InvalidDataFailureState extends EditProfileState {
  final String error;
  InvalidDataFailureState({required this.error});
}

class UserNotFoundFailureState extends EditProfileState {
  final String error;
  UserNotFoundFailureState({required this.error});
}

class DuplicateEmailFailureState extends EditProfileState {
  final String error;
  DuplicateEmailFailureState({required this.error});
}

class ServerFailureState extends EditProfileState {
  final String error;
  ServerFailureState({required this.error});
}