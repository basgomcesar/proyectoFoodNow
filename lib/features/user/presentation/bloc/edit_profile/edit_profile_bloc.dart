// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'edit_profile_event.dart';
import 'dart:typed_data';
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
          Uint8List.fromList(event.profileImage.codeUnits),
        );

        failureOrUser.fold(
          (failure) {
            emit(EditProfileStateFailure(error: failure.message));
          },
          (user) => emit(EditProfileStateSucess()),
        );
        // Verifica que el evento ha llegado al Bloc
        print('Datos dentro del bloc:');
        print('Nombre: ${event.name}');
        print('Correo: ${event.email}');
        print('Contraseña: ${event.password}');
        } catch (e) {
          emit(EditProfileStateFailure(error: e.toString()));
        }
        
        
      }
    });
  }

}


