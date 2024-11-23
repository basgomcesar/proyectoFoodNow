import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class GeteAvailabilityUseCase {
  final UserRepository repository;

  GeteAvailabilityUseCase({required this.repository});

  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUserAvailability(userId);
  }
}
