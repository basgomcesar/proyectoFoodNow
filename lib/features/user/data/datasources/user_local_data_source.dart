import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loging_app/features/user/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser(String userId);
  Future<bool> updateUser(UserModel user);
  Future<bool> deleteUser(String userId);
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> authenticateUser(String email, String password);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FirebaseFirestore firestore;
  final String collection = 'pBNlcuNDnYWJ7Coqu2oP';

  UserLocalDataSourceImpl({required this.firestore});
  
  @override
  Future<UserModel> authenticateUser(String email, String password) {
    // TODO: implement authenticateUser
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> createUser(user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }
  
  @override
  Future<bool> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
  @override
  Future<bool> updateUser(user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}