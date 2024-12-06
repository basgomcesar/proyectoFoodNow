import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class UpdateAvailabilityUseCase {
  final UserRepository repository;

  UpdateAvailabilityUseCase({required this.repository});

  Future<Either<Failure, User>> call(bool availability, String location) async {
    return await repository.updateAvailability(availability, location);
  }
}
