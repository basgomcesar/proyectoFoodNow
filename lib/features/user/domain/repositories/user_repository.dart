import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId); 
  Future<Either<Failure, bool>> updateUser(User user);  
  Future<Either<Failure, bool>> deleteUser(String userId); 
  Future<Either<Failure, User>> createUser(String name, String email, String password, String userType, String profileImage, bool disponibility);  
  Future<Either<Failure, User>> authenticateUser(String email, String password); 
}

