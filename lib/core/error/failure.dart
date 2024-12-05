abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class LocalFailure extends Failure {
  LocalFailure(super.message);
}

// Caixba
//DeleteUserFailure
class DuplicateEmailFailure extends Failure {
  DuplicateEmailFailure(super.message);
}

class InvalidDataFailure extends Failure {
  InvalidDataFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}
