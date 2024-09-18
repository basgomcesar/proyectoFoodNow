import '../services/AuthService.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<bool> login(String email, String password) async {
    return await _authService.login(email, password);
  }
}