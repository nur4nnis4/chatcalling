import '../../../../core/error/failures.dart';
import '../repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateReadStatus {
  final MessageRepository repository;
  UpdateReadStatus(this.repository);

  Future<Either<Failure, String>> call(
      {required String userId, required String conversationId}) async {
    return repository.updateReadStatus(userId, conversationId);
  }
}
