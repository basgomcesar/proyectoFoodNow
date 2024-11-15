
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:loging_app/core/utils/session.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<UserModel> updateUser(
      String name,
      String email,
      String password,
      Uint8List photo,
      );
  Future<bool> deleteUser(String userId);
  Future<UserModel> createUser(
      String name,
      String email,
      String password,
      String userType,
      Uint8List photo,
      bool disponibility,
    );
  Future<UserModel> authenticateUser(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client = Dio();
  // Eliminar la referencia a FirebaseFirestore
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

  // Constructor sin FirebaseFirestore
  UserRemoteDataSourceImpl();

  @override
  Future<UserModel> authenticateUser(String correo, String password) async {    
    final Response response = await client.post(
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
          name: response.data['nombre'], 
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: 'userType',
          photo: Uint8List.fromList(List<int>.from(response.data['foto']['data'])), // Convierte la foto a Uint8List si es un arreglo de bytes
          disponibility: true,
        );
        session.startSession(userId: idUsuario.toString(), token: token, user: userAuth);
        return userAuth;
      } catch (e) {
        throw Exception('Failed to authenticate user');
      }
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

@override
Future<UserModel> createUser(String name, String email, String password, String userType, Uint8List photo, bool disponibility) async {
  final response = await client.post(
    '$apiUrl/usuarios',
    data: {
      'nombre': name,
      'correo': email,
      'contrasenia': password,
      'tipo': userType,
      'foto': photo,
      'disponibilidad': disponibility,
    },
    options: Options(headers: {'Content-Type': 'application/json'}),
  );

  if (response.statusCode == 201) {
    try {
      // Asegúrate de que los datos de la respuesta sean correctos
      print(response.data);  // Imprime la respuesta para revisar los datos

      return UserModel(
        name: response.data['nombre'],
        email: response.data['correo'],
        password: response.data['contrasenia'],
        userType: response.data['tipo'],
        photo: Uint8List.fromList(List<int>.from(response.data['foto'])), // Convierte la foto a Uint8List si es un arreglo de bytes
        disponibility: response.data['disponibilidad'],
      );
    } catch (e) {
      print('Error en createUser: $e');
      throw Exception('Failed to register user1');
    }
  } else {
    print('Error en la respuesta: ${response.statusCode}');
    throw Exception('Failed to register user2');
  }
}


@override
  Future<UserModel> updateUser(String name, String email, String password, Uint8List photo) async {
    
    final response = await client.put(
      '$apiUrl/usuarios/', 
      data: {
        'nombre': name,
        'correo': email,
        'contrasenia': password,
        'foto': photo,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'x-token ${session.token}',
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<bool> deleteUser(String userId) async {
    final response = await client.delete('$apiUrl/$userId');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final response = await client.get('$apiUrl/$userId');

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get user');
    }
  }

  
}
