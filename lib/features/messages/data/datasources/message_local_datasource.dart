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
      List<ConversationModel> conversationsToCache) async {
    // TODO: implement cacheConversations
    return Right('');
  }

  @override
  Future<Either<Failure, String>> cacheMessages(
      List<MessageModel> messagesToCache) async {
    // TODO: implement cacheMessages
    return Right('');
  }

  @override
  Future<Either<Failure, List<ConversationModel>>> getConversations() async {
    // TODO: implement getConversations
    return Left(CacheFailure('CacheFailure yow'));
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages() async {
    // TODO: implement getMessages
    return Left(CacheFailure('CacheFailure'));
  }
}
