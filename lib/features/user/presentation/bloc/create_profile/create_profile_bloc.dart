// create_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'create_profile_event.dart';
import 'create_profile_state.dart';
import 'package:loging_app/features/user/domain/use_cases/create_profile_use_case.dart';


class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final CreateProfileUseCase createProfileUseCase;

  CreateProfileBloc({required this.createProfileUseCase}) : super(CreateProfileStateInitial()) {
    on<CreateProfileEvent>((event, emit) async {
      if (event is CreateProfileButtonPressed) {
        emit(CreateProfileStateLoading());

        final failureOrUser = await createProfileUseCase(
          event.name, 
          event.email, 
          event.password, 
          event.userType,
           event.profileImage,
            true,);

        failureOrUser.fold(
          (failure) {
            emit(CreateProfileStateFailure(error: failure.message));
          },
          (user) => emit(CreateProfileStateSucess()),
        );
      }
    });
  }

}


