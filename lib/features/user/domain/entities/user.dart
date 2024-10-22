class User {
  final String name;
  final String lastName;
  final String email;
  final String password; 
  final String? photo; 
  final String? phoneNumber; 
  final String userType;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    this.photo,
    this.phoneNumber,
    required this.userType,
  });
}
