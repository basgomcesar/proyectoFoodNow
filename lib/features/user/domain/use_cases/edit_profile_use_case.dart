
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/features/user/domain/repositories/user_repository.dart';

class EditProfileUseCase {
  final UserRepository repository;

  EditProfileUseCase({required this.repository});

  Future<Either<Failure, bool>> call(String name, String email, String password, Uint8List profileImage) async {      
    return await repository.updateUser(name, email, password, profileImage);      
  }  
  
}

