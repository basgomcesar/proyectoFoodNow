import 'dart:typed_data';
 
import 'package:dio/dio.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:loging_app/core/utils/session.dart';
 
abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<UserModel> updateUser(
      String name,
      String email,
      String password,
      Uint8List photo,
      );
  Future<bool> deleteUser();
  Future<UserModel> createUser(
      String name,
      String email,
      String password,
      String userType,
      Uint8List photo,
      bool disponibility,
    );
  Future<UserModel> authenticateUser(String email, String password);

  Future<UserModel> updateAvailability(bool availability, String location);
  
}
 
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client = Dio();
  final String apiUrl = 'http://localhost:3000'; // URL de tu API
  final Session session = Session.instance;

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
          userType: response.data['tipo'],
          photo: Uint8List.fromList(List<int>.from(response.data['foto']['data'])), // Convierte la foto a Uint8List si es un arreglo de bytes
          disponibility: response.data['disponibilidad'] == 1, 
          location: response.data['ubicacion'],
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
   FormData formData = FormData.fromMap({
        'nombre': name,
        'correo': email,
        'contrasenia': password,
        'tipo': userType,
        'foto': MultipartFile.fromBytes(photo, filename: 'photo.jpg'),  // Convierte la foto a MultipartFile
        'disponibilidad': disponibility,
      });
  final response = await client.post(
        '$apiUrl/usuarios',
        data: formData,  
      );
 
  if (response.statusCode == 201) {
    try {
 
      return UserModel(
        name: response.data['nombre'],
        email: response.data['correo'],
        password: response.data['contrasenia'],
        userType: response.data['tipo'],
        photo: Uint8List.fromList(List<int>.from(response.data['foto']['data'])),
        disponibility: response.data['disponibilidad'] == 'true', location: '',
      );
    } catch (e) {
      throw Exception('Failed to register user1');
    }
  } else {
    print('Error en la respuesta: ${response.statusCode}');
    throw Exception('Failed to register user2');
  }
}
 
 
@override
  Future<UserModel> updateUser(String name, String email, String password, Uint8List photo) async {
    FormData formData = FormData.fromMap({
        'nombre': name,
        'correo': email,
        'contrasenia': password,
        'foto': MultipartFile.fromBytes(photo, filename: 'photo.jpg'),  // Convierte la foto a MultipartFile
      });

    String? userId = session.userId;  
    if (userId == null) {
      throw Exception('User ID is not available');
    }
  try{
      final response = await client.put(
        '$apiUrl/usuarios/$userId',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'x-token': session.token,
          },
        ),
      );    
 
      if (response.statusCode == 200) {
        return UserModel(
          name: response.data['nombre'],
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: response.data['tipo'],
          photo: Uint8List.fromList(List<int>.from(response.data['foto']['data'])),
          disponibility: response.data['disponibilidad'] == 'true', location: '',
        );
      } else if (response.statusCode == 400) {
        throw Exception('Invalid data provided');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception('Failed to update user with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
 
  @override
  Future<bool> deleteUser() async {
    String? userId = session.userId;  
    if (userId == null) {
      throw Exception('User ID is not available');
    }
    try{
        final response = await client.delete(
          '$apiUrl/usuarios/$userId', 
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
          throw Exception('Failed to update user with status code ${response.statusCode}');
        }
    } catch (e) {
      throw Exception('Failed to update user: $e');
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

  @override
  Future<UserModel> updateAvailability(bool availability, String location) async {
    // Asegúrate de que tienes el idUsuario en la sesión
    String? userId = session.userId;  // Esto es obtenido desde tu singleton Session
    if (userId == null) {
      throw Exception('User ID is not available');
    }
    try{
      final response = await client.put(
        '$apiUrl/usuarios/availability/$userId',
        data: {
          'disponibilidad': availability,
          'ubicacion': location
        },
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
          name: response.data['nombre'],
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: response.data['tipo'],
          photo: Uint8List.fromList(List<int>.from(response.data['foto']['data'])),
          disponibility: response.data['disponibilidad'] == 1, location: '',
        );

        
      } else if (response.statusCode == 400) {
        throw Exception('Invalid data provided');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Failed to update user with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
  
}