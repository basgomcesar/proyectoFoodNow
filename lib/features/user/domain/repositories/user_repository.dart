import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import 'package:loging_app/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId); 
  Future<Either<Failure, User>> updateUser(String name, String email, String password, Uint8List profileImage);  
  Future<Either<Failure, bool>> deleteUser(); 
  Future<Either<Failure, User>> createUser(String name, String email, String password, String userType, Uint8List profileImage, bool disponibility);  
  Future<Either<Failure, User>> authenticateUser(String email, String password); 
  Future<Either<Failure, User>> updateAvailability(bool availability, String location);
}
