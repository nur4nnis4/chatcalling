import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';

class IsSignedIn {
  final AuthRepository repository;

  IsSignedIn(this.repository);

  Stream<bool> call() async* {
    yield* repository.isSignedIn();
  }
}
