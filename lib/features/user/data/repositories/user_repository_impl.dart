
import 'package:dartz/dartz.dart';

import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';

import 'package:loging_app/features/user/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, User>> authenticateUser(String email, String password) async {
    try {
      print('UserRepositoryImpl: authenticateUser');
      print('email: $email');
      print('password: $password');
      final User user = await userRemoteDataSource.authenticateUser(email, password);// Aquí se hace la petición al servidor
      print('UserRepositoryImpl: authenticateUser: user: $user');
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Authentication failed'));
    }
  }
 
  @override
  Future<Either<Failure, User>> createUser(String name, String email, String password, String userType, String profileImage, bool disponibility ) async {
    try {
      print('name: $name');
      print('email: $email');
      print('password: $password');
      print('userType: $userType');
      print('email: $disponibility');
      final User user = await userRemoteDataSource.createUser(name, email, password, userType, profileImage, disponibility);// Aquí se hace la petición al servidor
      print('Usuario creado correctamente en el datasource');
      return Right(user);
    } catch (e) {
      print('Error en createUser en UserRepositoryImpl: $e');
      return Left(ServerFailure('Create user failed'));
    }
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