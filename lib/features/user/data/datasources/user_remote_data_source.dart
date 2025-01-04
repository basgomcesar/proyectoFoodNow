import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:loging_app/core/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:loging_app/core/utils/session.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<bool> updateUser(
    String name,
    String email,
    String password,
    Uint8List photo,
  );
  Future<bool> deleteUser();
  Future<bool> createUser(UserModel userModel);
  Future<UserModel> authenticateUser(String email, String password);

  Future<UserModel> updateAvailability(bool availability, String location);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dioClient = Dio();
  final String apiUrl ; // URL de tu API
  final Session session = Session.instance;

  UserRemoteDataSourceImpl({required this.apiUrl});

  @override
  Future<UserModel> authenticateUser(String correo, String password) async {
    final Response response = await dioClient.post(
      '$apiUrl/auth/login',
      data: {
        'correo': correo,
        'contrasenia': password,
      },
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      try {
        final idUsuario = response.data['idUsuario'];
        final token = response.headers['x-token']?.first ?? '';
        UserModel userAuth = UserModel(
          //Se agreg[o el idUsuario]
          name: response.data['nombre'],
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: response.data['tipoUsuario'],
            photo: response.data['foto'] != null
              ? Uint8List.fromList(List<int>.from(response.data['foto']['data']))
              : Uint8List(0), // Si no hay foto, crea un Uint8List vacío
          disponibility: response.data['disponibilidad'] == 1,
          location: response.data['ubicacion'] ?? '',
        );
        session.startSession(
            userId: idUsuario.toString(), token: token, user: userAuth);
        return userAuth;
      } catch (e) {
        print('Failed to authenticate user1');
        throw Exception('Failed to authenticate user1');        
      }
    } else {
      print('Failed to authenticate user2');
      throw Exception('Failed to authenticate user2');
    }
  }

  @override
  Future<bool> createUser(UserModel userModel) async {

    try {
      final response = await dioClient.post(
        '$apiUrl/users',
        data: userModel.toFormData(),
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      
      switch (response.statusCode) {
        case 201:
          return true; 
        case 409: 
          throw DuplicateEmailFailure('El correo ya está registrado.');
        case 400: 
          throw InvalidDataFailure('Datos inválidos enviados al servidor.');
        case 500: 
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> updateUser(
      String name, String email, String password, Uint8List photo) async {
    final formData = FormData.fromMap({
      'nombre': name,
      'correo': email,
      'contrasenia': password,
      'foto': MultipartFile.fromBytes(photo, filename: 'photo.jpg'),
    });


    try {
      final response = await dioClient.put(
        '$apiUrl/users',
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! < 500; // Considera válidos todos los códigos menores a 500
          },
          headers: {
            'Content-Type': 'multipart/form-data',
            'x-token': session.token,
          },
        ),
      );

      print('Response STATUS CODE: ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          return true; // Usuario actualizado correctamente
        case 400:
          throw InvalidDataFailure('No se ha proporcionado ningún dato para actualizar');
        case 404:
          throw UserNotFoundFailure('Usuario no encontrado.');
        case 409:
          throw DuplicateEmailFailure('El correo ya está registrado por otro usuario.');
        case 500:
          throw ServerFailure('Error en el servidor. Inténtalo más tarde.');
        default:
          throw UnknownFailure(
            'Error desconocido: ${response.statusCode}',
          );
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }


  @override
  Future<bool> deleteUser() async {
    
    try {
      final response = await dioClient.delete(
        '$apiUrl/users',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'x-token': session.token,
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception('Invalid data provided');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception(
            'Failed to update user with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final response = await dioClient.get('$apiUrl/$userId');

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<UserModel> updateAvailability(
      bool availability, String location) async {
    // Asegúrate de que tienes el idUsuario en la sesión
    String? userId =
        session.userId; // Esto es obtenido desde tu singleton Session
    if (userId == null) {
      throw Exception('User ID is not available');
    }
    try {
      final response = await dioClient.put(
        '$apiUrl/usuarios/availability/$userId',
        data: {'disponibilidad': availability, 'ubicacion': location},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-token': session.token,
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');

        return UserModel(
          //Se agreg[o el idUsuario]
          name: response.data['nombre'],
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: response.data['tipo'],
          photo:
              Uint8List.fromList(List<int>.from(response.data['foto']['data'])),
          disponibility: response.data['disponibilidad'] == 1,
          location: '',
        );
      } else if (response.statusCode == 400) {
        throw Exception('Invalid data provided');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception(
            'Failed to update user with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }



}
