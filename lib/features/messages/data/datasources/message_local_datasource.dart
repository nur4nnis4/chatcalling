import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class MessageLocalDatasource {
  Future<Either<Failure, List<MessageModel>>> getMessages();
  Future<Either<Failure, String>> cacheMessages(
      List<MessageModel> messagesToCache);
  Future<Either<Failure, List<ConversationModel>>> getConversations();
  Future<Either<Failure, String>> cacheConversations(
      List<ConversationModel> conversationsToCache);
}

class MessageLocalDatasourceImpl extends MessageLocalDatasource {
  @override
  Future<Either<Failure, String>> cacheConversations(
      List<ConversationModel> conversationsToCache) {
    // TODO: implement cacheConversations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> cacheMessages(
      List<MessageModel> messagesToCache) {
    // TODO: implement cacheMessages
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ConversationModel>>> getConversations() {
    // TODO: implement getConversations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}
