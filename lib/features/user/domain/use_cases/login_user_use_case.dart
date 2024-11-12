
import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase({required this.repository});

  Future<Either<Failure, User>> call(String email, String password) async {
    print('Correo login use case: $email');
    print('Contraseña login use case: $password');
    return await repository.authenticateUser(email, password);
  }
}