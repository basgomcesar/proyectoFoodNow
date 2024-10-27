import 'package:loging_app/features/user/domain/entities/user.dart';

class UserModel  extends User{
  UserModel({required super.name, required super.lastName, required super.email, required super.password, required super.userType, required photo, required phoneNumber});
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      photo: json['photo'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'photo': photo,
      'phoneNumber': phoneNumber,
      'password': password,
      'userType': userType,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      name: user.name,
      lastName: user.lastName,
      email: user.email,
      photo: user.photo,
      phoneNumber: user.phoneNumber,
      password: user.password,
      userType: user.userType,
    );
  }

  get id => null;
  
}