import 'package:dio/dio.dart';
import 'package:loging_app/features/user/domain/entities/user.dart';

class UserModel extends User {
  // Constructor modificado para que reciba los parámetros directamente
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.photo,
    required super.userType,
    required super.disponibility, 
    required super.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      password: json['password'],
      userType: json['userType'],
      disponibility: json['disponibility'], location: '',
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
      location: '',
    );
  }


  FormData toFormData() {
    return FormData.fromMap({
      'nombre': name,
      'correo': email,
      'contrasenia': password,
      'tipo': userType,
      'disponibilidad': disponibility,
      'foto': MultipartFile.fromBytes(photo, filename: 'photo.jpg'),
      'ubicación': location,
    });
  }

//  get id => null;
  
}
