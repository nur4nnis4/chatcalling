import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class PlatformFailure extends Failure {
  const PlatformFailure(String message) : super(message);
}

class PluginFailure extends Failure {
  PluginFailure(String message) : super(message);
}
