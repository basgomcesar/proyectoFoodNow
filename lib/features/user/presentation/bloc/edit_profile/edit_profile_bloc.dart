// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:loging_app/core/error/failure.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';
import 'package:loging_app/features/user/domain/use_cases/edit_profile_use_case.dart';


class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase editProfileUseCase;

  EditProfileBloc({required this.editProfileUseCase}) : super(EditProfileStateInitial()) {
    on<EditProfileEvent>((event, emit) async {
      if (event is EditProfileButtonPressed) {
        try{
          emit(EditProfileStateLoading());
        
        final failureOrUser = await editProfileUseCase(
          event.name, 
          event.email, 
          event.password, 
          event.profileImage,
        );

        failureOrUser.fold(
          (failure) {
            if (failure is InvalidDataFailure) {
              emit(InvalidDataFailureState(error: 'No hay datos a actualizar'));

            } else if(failure is UserNotFoundFailure) {
              emit(UserNotFoundFailureState(error: 'Usuario no encontrado'));

            } else if(failure is DuplicateEmailFailure) {
              emit(DuplicateEmailFailureState(error: 'El correo electrónico ya está en uso.'));
              
            } else if(failure is ServerFailure) {
              emit(EditProfileStateFailure(error: 'Ocurrió un error al actualizar el perfil.'));
            } 
            emit(EditProfileStateFailure(error: failure.message));
          },
          (bool) => emit(EditProfileStateSucess()),
        );
        
        } catch (e) {
          emit(EditProfileStateFailure(error: e.toString()));
        }
        
        
      }
    });
  }

}


