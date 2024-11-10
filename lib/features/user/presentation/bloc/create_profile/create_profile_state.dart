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

class CreateProfileStateFailure extends CreateProfileState {
  final String error;

  CreateProfileStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
