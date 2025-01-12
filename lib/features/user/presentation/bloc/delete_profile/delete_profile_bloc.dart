// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:loging_app/core/error/failure.dart';
import 'delete_profile_event.dart';
import 'delete_profile_state.dart';
import 'package:loging_app/features/user/domain/use_cases/delete_profile_use_case.dart';


class DeleteProfileBloc extends Bloc<DeleteProfileEvent, DeleteProfileState> {
  final DeleteProfileUseCase deleteProfileUseCase;

  DeleteProfileBloc({required this.deleteProfileUseCase}) : super(DeleteProfileStateInitial()) {
    on<DeleteProfileEvent>((event, emit) async {
      if (event is DeleteProfileButtonPressed) {
        try{
          emit(DeleteProfileStateLoading());
        
        final failureOrUser = await deleteProfileUseCase( );

        failureOrUser.fold(
          (failure) {
            if (failure is InvalidDataFailure) {
              emit(InvalidDataFailureState(error: 'Id no valido.'));

            } else if(failure is UnauthorizedFailure) {
              emit(UnauthorizedFailureState(error: 'Token no válido.'));

            } else if(failure is UserNotFoundFailure) {
              emit(UserNotFoundFailureState(error: 'Usuario no encontrado.'));
              
            } else if(failure is ServerFailure) {
              emit(ServerFailureState(error: 'Ocurrió un error en el servidor.'));
            } 
            emit(DeleteProfileStateFailure(error: failure.message));
          },
          (bool) => emit(DeleteProfileStateSucess()),
        );
        
        } catch (e) {
          emit(DeleteProfileStateFailure(error: e.toString()));
        }
        
        
      }
    });
  }

}


