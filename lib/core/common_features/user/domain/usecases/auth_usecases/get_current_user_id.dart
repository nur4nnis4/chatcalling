import 'package:chatcalling/core/common_features/user/domain/repositories/auth_repository.dart';

class GetCurrentUserId {
  final AuthRepository repository;

  GetCurrentUserId(this.repository);

  Future<String> call() {
    return repository.getCurrentUserId();
  }
}
