// login_event.dart
import 'package:equatable/equatable.dart';//Equatable es una clase que nos permite comparar objetos de una manera más sencilla.

abstract class UpdateAvailabilityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AvailabilityButtonPressed extends UpdateAvailabilityEvent {
  final bool availability;
  final String location;

  AvailabilityButtonPressed({
  required this.availability,
  required this.location,
  });
}