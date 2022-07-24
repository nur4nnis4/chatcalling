import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/conversation.dart';
import '../repositories/message_repository.dart';

class GetConversation {
  final MessageRepository repository;
  GetConversation(this.repository);

  Future<Either<Failure, List<Conversation>>> call(
      {required String userId}) async {
    return await repository.getConversations(userId);
  }
}
