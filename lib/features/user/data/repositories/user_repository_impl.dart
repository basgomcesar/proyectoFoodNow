import 'dart:typed_data';
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
  Future<Either<Failure, User>> createUser(String name, String email, String password, String userType, Uint8List profileImage, bool disponibility ) async {
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
  Future<Either<Failure, User>> updateUser(String name, String email, String password, Uint8List profileImage)async{
    try {
          print('name: $name');
          print('email: $email');
          print('password: $password');
          final User user = await userRemoteDataSource.updateUser(name, email, password, profileImage);// Aquí se hace la petición al servidor
          print('Usuario actualizado correctamente en el datasource');
          return Right(user);
    } catch (e) {
          print('Error en updateUser en UserRepositoryImpl: $e');
          return Left(ServerFailure('Update user failed'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async{
    try {
      final bool result = await userRemoteDataSource.deleteUser();// Aquí se hace la petición al servidor
      return Right(result);
    } catch (e) {
      print('Error en deleteUser en UserRepositoryImpl: $e');
      return Left(ServerFailure('Delete user failed'));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  
  @override
  Future<Either<Failure, User>> updateAvailability(bool availability, String location) async {
    try {
          print('disponibilidad: $availability');
          print('location: $location');
          final User user = await userRemoteDataSource.updateAvailability(availability, location);// Aquí se hace la petición al servidor
          print('Usuario actualizado correctamente en el datasource');
          return Right(user);
    } catch (e) {
          print('Error en updateUser en UserRepositoryImpl: $e');
          return Left(ServerFailure('Update user failed'));
    }
  }
  
  
  

  
}