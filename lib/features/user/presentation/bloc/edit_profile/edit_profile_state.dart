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
