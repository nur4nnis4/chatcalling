import '../entities/conversation.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Stream<Either<Failure, List<Message>>> getMessages(String conversationId);
  Future<Either<Failure, String>> sendMessage(Message message);
  Stream<Either<Failure, List<Conversation>>> getConversations(String userId);
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId);
}
