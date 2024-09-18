import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String authUrl = 'http://api.distribuido.com/auth/login'; // URL de autenticación

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(authUrl),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true; // Login exitoso
    } else {
      return false; // Login fallido
    }
  }
}
