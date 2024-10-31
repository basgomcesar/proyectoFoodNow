import 'package:dio/dio.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<bool> updateUser(UserModel user);
  Future<bool> deleteUser(String userId);
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> authenticateUser(String email, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client = Dio();
  // Eliminar la referencia a FirebaseFirestore
  final String apiUrl = 'http://localhost:3000/auth/login'; // URL de tu API

  // Constructor sin FirebaseFirestore
  UserRemoteDataSourceImpl();

  @override
  Future<UserModel> authenticateUser(String correo, String password) async {
    
    final response = await client.post(
      apiUrl,
      data: {
        'correo': correo,
        'password': password,
      },
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      print('UserRemoteDataSourceImpl: authenticateUser: response.data: ${response.data}');
      //Hacer un usermodel de prueba que se regrese en lugar de response.data para que no falle el login en el login_user_bloc.dart
      return UserModel (
        name: 'name', //Lo que hac eesta linea es que si el login es exitoso, se regresa un usermodel con los datos que se necesitan para que no falle el login en el login_user_bloc.dart
        lastName: 'lastName',
        email: response.data['correo'],
        password: response.data['password'],
        phoneNumber: 'telefono',
        userType: 'userType',
        photo: 'photo',
      );

    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.post(
      apiUrl,
      data: user.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create user');
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

  @override
  Future<bool> updateUser(UserModel user) async {
    final response = await client.put(
      '$apiUrl/${user.id}', // Suponiendo que 'id' es el identificador del usuario
      data: user.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user');
    }
  }
}
