import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/conversation.dart';
import '../repositories/message_repository.dart';

class GetConversations {
  final MessageRepository repository;
  GetConversations(this.repository);

  Stream<Either<Failure, List<Conversation>>> call(
      {required String userId}) async* {
    yield* repository.getConversations(userId);
  }
}
