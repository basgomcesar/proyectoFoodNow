
import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/Failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/UserRepository.dart';

class Loginuserusecase {
  final UserRepository repository;

  Loginuserusecase({required this.repository});

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.authenticateUser(email, password);
  }
}