import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:loging_app/core/error/failure.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  final Dio dioClient = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  @override
  Future<Either<Failure, User>> authenticateUser(String email, String password) async {
    try {
      final User user = await userRemoteDataSource.authenticateUser(email, password);// Aquí se hace la petición al servidor
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Authentication failed'));
    }
  }
 
@override
Future<Either<Failure, bool>> createUser(User user) async {

  try {
    final createdUser = await userRemoteDataSource.createUser(UserModel.fromEntity(user));

    return Right(createdUser);
    
  } on DuplicateEmailFailure catch (e) {
    print('Error en createUser (Correo duplicado): ${e.message}');
    return Left(DuplicateEmailFailure(e.message));

  } on InvalidDataFailure catch (e) {
    print('Error en createUser (Datos inválidos): ${e.message}');
    return Left(InvalidDataFailure(e.message));

  } on ServerFailure catch (e) {
    print('Error en createUser (Error del servidor): ${e.message}');
    return Left(ServerFailure(e.message));

  } on UnknownFailure catch (e) {
    print('Error en createUser (Error desconocido): ${e.message}');
    return Left(UnknownFailure(e.message));
    
  } catch (e, stackTrace) {
    print('Error inesperado en createUser: $e');
    print('StackTrace: $stackTrace');
    return Left(UnknownFailure('Ocurrió un error inesperado.'));
  }
}


@override
  Future<Either<Failure, bool>> updateUser(String name, String email, String password, Uint8List profileImage)async{
    try {
          print('Datos enviados: name=$name, email=$email, password=$password');
          final bool user = await userRemoteDataSource.updateUser(name, email, password, profileImage);
          return Right(user);
    } on InvalidDataFailure catch (e) {
      print('Error en editUser (Sin datos): ${e.message}');
      return Left(InvalidDataFailure(e.message));

    } on UserNotFoundFailure catch (e) {
      print('Error en editUser (usuarioNoEncontrado): ${e.message}');
      return Left(UserNotFoundFailure(e.message));

    } on DuplicateEmailFailure catch (e) {
      print('Error en editUser (Correo duplicado): ${e.message}');
      return Left(DuplicateEmailFailure(e.message));

    }on ServerFailure catch (e) {
      print('Error en editUser (Error en servidor): ${e.message}');
      return Left(ServerFailure(e.message));
      
    } catch (e) {     
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