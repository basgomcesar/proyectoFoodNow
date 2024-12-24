import 'dart:typed_data';

class User {
  final String name;
  final String email;
  final String password; 
  final Uint8List photo; 
  final String userType;
  bool disponibility;
  String location;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
    required this.userType,
    required this.disponibility,
    required this.location,
  });

  User copyWith({
    String? name,
    String? email,
    String? password,
    Uint8List? photo,
    String? userType,
    bool? disponibility,
    String? location,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photo: photo ?? this.photo,
      userType: userType ?? this.userType,
      disponibility: disponibility ?? this.disponibility,
      location: location ?? this.location,
    );
  }
}
