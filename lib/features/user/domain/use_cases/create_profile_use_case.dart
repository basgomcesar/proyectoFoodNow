
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class CreateProfileUseCase {
  final UserRepository repository;

  CreateProfileUseCase({required this.repository});

  Future<Either<Failure, bool>> call(User user) async {      
    return await repository.createUser(user);      
  }  
  
}

