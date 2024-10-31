// login_bloc.dart
import 'package:bloc/bloc.dart';
import 'login_user_event.dart';
import 'login_user_state.dart';
import 'package:loging_app/features/user/domain/use_cases/login_user_use_case.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginBloc({required this.loginUserUseCase}) : super(LoginInitial()){
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        print("LoginButtonPressed");
        emit(LoginLoading());// Emitimos el estado de carga
        // Agregamos 4 segundos de delay para simular una petición a una API
        await Future.delayed(Duration(seconds: 4));
        print("Despues de 4 segundos el usuario es: ${event.email} y la contraseña es: ${event.password}");
        final failureOrUser = await loginUserUseCase(event.email, event.password);

        print("Este el fail or user $failureOrUser");
        failureOrUser.fold(
          (failure) {
            print("Error al autenticar al usuario ${failure.message}");
            emit(LoginFailure(error: failure.message));
          },
          (user) => emit(LoginSuccess()),
        );
      }
    });
  }
}
