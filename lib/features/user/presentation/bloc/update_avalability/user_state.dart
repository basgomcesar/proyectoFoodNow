import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loging_app/core/utils/session.dart';

// Definir los estados de UserCubit
abstract class UserState {}

class UserInitial extends UserState {}

class UserAvailabilityUpdated extends UserState {
  final bool isAvailable;

  UserAvailabilityUpdated(this.isAvailable);
}

// UserCubit para manejar la disponibilidad
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  // Función para actualizar la disponibilidad
  void updateAvailability(bool isAvailable) {
    // Utilizamos el método copyWith para crear una nueva instancia del usuario con la disponibilidad actualizada
    if (Session.instance.user != null) {
      Session.instance.user = Session.instance.user!.copyWith(disponibility: isAvailable);
      emit(UserAvailabilityUpdated(isAvailable));  // Emitir el nuevo estado
    }
  }
}