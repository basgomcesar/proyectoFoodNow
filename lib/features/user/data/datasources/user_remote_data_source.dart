import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore firestore;
  final String collection = 'pBNlcuNDnYWJ7Coqu2oP';

  UserRemoteDataSourceImpl({required this.firestore});

  @override
  Future<UserModel> authenticateUser(String email, String password) async {
    return firestore
        .collection(collection)
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data());
      } else {
        throw Exception('User not found');
      }
    });
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    // final response = await client.post(
    //   Uri.parse('http://localhost:3000/users'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(user.toJson()),
    // );

    // if (response.statusCode == 201) {
    //   return UserModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to create user');
    // }
    throw UnimplementedError('createUser method is not implemented');
  }

  @override
  Future<bool> deleteUser(String userId) async {
    // final response = await client.delete(
    //   Uri.parse('http://localhost:3000/users/$userId'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    // );

    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   throw Exception('Failed to delete user');
    // }
    throw UnimplementedError('deleteUser method is not implemented');
  }

  @override
  Future<UserModel> getUser(String userId) async {
    // final response = await client.get(Uri.parse('http://localhost:3000/users/$userId'));

    // if (response.statusCode == 200) {
    //   return UserModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to get user');
    // }
    throw UnimplementedError('getUser method is not implemented');
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    // final response = await client.put(
    //   Uri.parse('http://localhost:3000/users/${user.email}'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(user.toJson()),
    // );

    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   throw Exception('Failed to update user');
    // }
    throw UnimplementedError('updateUser method is not implemented');
  }
}