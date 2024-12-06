// login_state.dart
import 'package:equatable/equatable.dart';

abstract class CreateProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateProfileStateInitial extends CreateProfileState {
  
}

class CreateProfileStateLoading extends CreateProfileState {
}

class CreateProfileStateSucess extends CreateProfileState {
  
}
//
class DuplicateEmailFailureState extends CreateProfileState {
  final String error;
  DuplicateEmailFailureState({required this.error});
}

class CreateProfileStateFailureState extends CreateProfileState {
  final String error;
  CreateProfileStateFailureState({required this.error});
}

class InvalidDataFailureState extends CreateProfileState {
  final String error;
  InvalidDataFailureState({required this.error});
}
