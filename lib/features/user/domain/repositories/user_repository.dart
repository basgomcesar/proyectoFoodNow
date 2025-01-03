import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId); 
  Future<Either<Failure, bool>> updateUser(String name, String email, String password, Uint8List profileImage);  
  Future<Either<Failure, bool>> deleteUser(); 
  Future<Either<Failure, bool>> createUser(User user);  
  Future<Either<Failure, User>> authenticateUser(String email, String password); 
  Future<Either<Failure, User>> updateAvailability(bool availability, String location);
}
