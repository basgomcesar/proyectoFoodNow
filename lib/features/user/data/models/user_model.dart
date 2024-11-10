import 'package:loging_app/features/user/domain/entities/user.dart';

class UserModel extends User {
  // Constructor modificado para que reciba los parámetros directamente
  UserModel({
    required String name,
    required String email,
    required String password,
    required String photo,
    required String userType,
    required bool disponibility,
  }) : super(
          name: name,
          email: email,
          password: password,
          photo: photo,
          userType: userType,
          disponibility: disponibility,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      password: json['password'],
      userType: json['userType'],
      disponibility: json['disponibility'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'photo': photo,
      'password': password,
      'userType': userType,
      'disponibility': disponibility,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      name: user.name,
      email: user.email,
      photo: user.photo,
      password: user.password,
      userType: user.userType,
      disponibility: user.disponibility,
    );
  }

  get id => null;
  
}