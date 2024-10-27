import 'package:loging_app/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class UserLocalDataSource {
  Future<UserModel?> getUser(String userId);
  Future<bool> updateUser(UserModel user);
  Future<bool> deleteUser(String userId);
  Future<bool> createUser(UserModel user);
  Future<UserModel?> authenticateUser(String email, String password);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> authenticateUser(String email, String password) async {
    final userJson = sharedPreferences.getString(email); // Suponiendo que el correo es el ID del usuario
    if (userJson != null) {
      final user = UserModel.fromJson(json.decode(userJson));
      if (user.password == password) {
        return user;
      }
    }
    return null; // Usuario no encontrado o contraseña incorrecta
  }

  @override
  Future<bool> createUser(UserModel user) async {
    // Almacena el usuario usando su email como clave
    final userJson = json.encode(user.toJson());
    return await sharedPreferences.setString(user.email, userJson);
  }

  @override
  Future<bool> deleteUser(String userId) async {
    return await sharedPreferences.remove(userId); // Suponiendo que userId es el email
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    final userJson = sharedPreferences.getString(userId); // Suponiendo que userId es el email
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null; // Usuario no encontrado
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    // Actualiza el usuario almacenando nuevamente con el mismo email
    return await createUser(user); // Reutilizar el método createUser para actualización
  }
}
