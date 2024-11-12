
import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class CreateProfileUseCase {
  final UserRepository repository;

  CreateProfileUseCase({required this.repository});

  Future<Either<Failure, User>> call(String name, String email, String password, String userType, String profileImage, bool disponibility) async {      
       // Imprimir los parámetros para verificar que se están enviando correctamente
    print('Nombre create usecase: $name');
    print('Correo create usecase: $email');
    print('Contraseña create usecase: $password');
    print('Tipo de usuario create usecase: $userType');
    print('Disponibilidad create usecase: $disponibility');
    return await repository.createUser(name, email, password, userType, profileImage, disponibility);      
  }  
  
}

