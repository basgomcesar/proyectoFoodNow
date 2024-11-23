import 'dart:typed_data';

class User {
  final String name;
  final String email;
  final String password; 
  final Uint8List photo; 
  final String userType;
  final bool disponibility;
  final String location;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
    required this.userType,
    required this.disponibility,
    required this.location
  });
}
