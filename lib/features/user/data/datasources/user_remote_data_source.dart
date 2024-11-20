
import 'package:dio/dio.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:loging_app/core/utils/session.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String userId);
  Future<bool> updateUser(UserModel user);
  Future<bool> deleteUser(String userId);
  Future<UserModel> createUser(
      String name,
      String email,
      String password,
      String userType,
      String? photo,
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
    final response = await client.post(
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
        session.startSession(userId: idUsuario.toString(), token: token);

        return UserModel(
          name: response.data['nombre'], 
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: 'userType',
          photo: 'photo',
          disponibility: true,
        );
      } catch (e) {
        throw Exception('Failed to authenticate user');
      }
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

@override
Future<UserModel> createUser(  String name,  String email,  String password,  String userType,  String? photo,  bool disponibility) async {

  final response  = await client.post(
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

  if(response.statusCode == 201) {
    try {
        
        return UserModel(
          name: response.data['nombre'], 
          email: response.data['correo'],
          password: response.data['contrasenia'],
          userType: response.data['tipo'], 
          photo: response.data['foto'], 
          disponibility: response.data['disponibilidad'], 
        );
      } catch (e) {
        throw Exception('Failed to register user');
      }
    } else {
      throw Exception('Failed to register user');
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
