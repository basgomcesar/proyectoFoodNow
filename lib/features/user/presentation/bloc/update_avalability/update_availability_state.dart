// login_state.dart
import 'package:equatable/equatable.dart';

abstract class UpdateAvailabilityState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateAvailabilityInitial extends UpdateAvailabilityState {}

class UpdateAvailabilityLoading extends UpdateAvailabilityState {
}

class UpdateAvailabilitySuccess extends UpdateAvailabilityState {
  
}

class UpdateAvailabilityFailure extends UpdateAvailabilityState {
  final String error;

  UpdateAvailabilityFailure({required this.error});

  @override
  List<Object> get props => [error];
}
