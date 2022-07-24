import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> getMessages(String conversationId);
  Future<Either<Failure, void>> sendMessage(Message message);
  Future<Either<Failure, List<Conversation>>> getConversations(String userId);
}
