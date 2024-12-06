// login_bloc.dart
import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/update_availability_use_case.dart';
import 'update_availability_event.dart';
import 'update_availability_state.dart';

class AvailabilityBloc extends Bloc<UpdateAvailabilityEvent, UpdateAvailabilityState> {
  final UpdateAvailabilityUseCase availabilityUseCase;

  AvailabilityBloc({required this.availabilityUseCase}) : super(UpdateAvailabilityInitial()){
    on<UpdateAvailabilityEvent>((event, emit) async {
      if (event is AvailabilityButtonPressed) {
        try{
          emit(UpdateAvailabilityLoading());
        

        final failureOrUser = await availabilityUseCase(
          event.availability, 
          event.location,
        );

        failureOrUser.fold(
          (failure) {
            emit(UpdateAvailabilityFailure(error: failure.message));
          },
          (user) => emit(UpdateAvailabilitySuccess()),
        );
        // Verifica que el evento ha llegado al Bloc
        print('Datos dentro del bloc update:');
        print('Disponibilidad: ${event.availability}');
        print('Location: ${event.location}');
        } catch (e) {
          emit(UpdateAvailabilityFailure(error: e.toString()));
        }
        
        
      }
    });
  }
}
