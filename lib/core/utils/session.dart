import 'package:loging_app/features/user/domain/entities/user.dart';

class Session {
  
  static final Session _instance = Session._internal();

  Session._internal();
  static Session get instance => _instance;

  String? userId;
  String? token;
  User? user;

  void startSession({required String userId, required String token, User? user}) {
    this.userId = userId;
    this.token = token;
    this.user = user;
  }

  void endSession() {
    userId = null;
    token = null;
    user = null;
  }

  bool get isLoggedIn => userId != null && token != null && user != null;
}
