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

//UpdateUserFailure
class NoDataFailure extends Failure {
  NoDataFailure(super.message);
}

class InternalErrorFailure extends Failure {
  InternalErrorFailure(super.message);
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure(super.message);
}

//AddProductFailure
class DuplicateProductFailure extends Failure {
  DuplicateProductFailure(super.message);
}
class InvalidPriceFailure extends Failure {
  InvalidPriceFailure(super.message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);
}
class OrderFailure extends Failure {
  OrderFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

