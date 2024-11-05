class Session {
  
  static final Session _instance = Session._internal();

  Session._internal();
  static Session get instance => _instance;

  String? userId;
  String? token;

  void startSession({required String userId, required String token}) {
    this.userId = userId;
    this.token = token;
  }

  void endSession() {
    userId = null;
    token = null;
  }

  bool get isLoggedIn => userId != null && token != null;
}
