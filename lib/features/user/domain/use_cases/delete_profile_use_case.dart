
import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class DeleteProfileUseCase {
  final UserRepository repository;

  DeleteProfileUseCase({required this.repository});

  Future<Either<Failure, bool>> call() async {      
    return await repository.deleteUser();      
  }  
  
}

