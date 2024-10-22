import 'package:dartz/dartz.dart';

import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/data/datasources/user_local_data_source.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';

import 'package:loging_app/features/user/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userLocalDataSource, required this.userRemoteDataSource});

  @override
  Future<Either<Failure, User>> authenticateUser(String email, String password) async {
    try {
      final User user = await userRemoteDataSource.authenticateUser(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Authentication failed'));
    }
  }

  @override
  Future<Either<Failure, User>> createUser(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}