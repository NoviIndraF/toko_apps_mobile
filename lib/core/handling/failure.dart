import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionFailure extends Failure {
  ConnectionFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}
