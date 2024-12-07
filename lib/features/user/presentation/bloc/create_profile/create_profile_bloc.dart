// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'create_profile_event.dart';
import 'create_profile_state.dart';
import 'package:loging_app/features/user/domain/use_cases/create_profile_use_case.dart';


class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final CreateProfileUseCase createProfileUseCase;

  CreateProfileBloc({required this.createProfileUseCase})
     : super(CreateProfileStateInitial()) {
    on<CreateProfileEvent>((event, emit) async {
      if (event is CreateProfileButtonPressed) {
        try{
          emit(CreateProfileStateLoading());
        // Simular un retraso de 2 segundos
          await Future.delayed(const Duration(seconds: 2));


        final User user = User(
          id: '',
          name: event.name,
          email: event.email,
          password: event.password,
          userType: event.userType,
          photo: event.photo,
          disponibility: event.disponibility,
          location: event.location

        );

        final failureOrUser = await createProfileUseCase(user);

           failureOrUser.fold(
            (failure) {
              if (failure is DuplicateEmailFailure) {
                emit(DuplicateEmailFailureState(error: 'El correo electrónico ya está en uso.')); // Mensaje específico
              
              } else if (failure is InvalidDataFailure) {
                emit(InvalidDataFailureState(error: 'Los datos ingresados son inválidos. Por favor, verifica tus datos.'));
             
              } else {
                //Cambiar el CreateProfileStateFailure porque eso causa e
                emit(CreateProfileStateFailureState(error: 'Ocurrió un error al crear el perfil.'));
              }
            },
            (bool) => emit(CreateProfileStateSucess()),
          );
        } catch (e) {
          emit(CreateProfileStateFailureState(error: 'Error inesperado: ${e.toString()}'));
        }        
        
      }
    });
  }

}


