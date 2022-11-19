import 'dart:async';

import '../datasources/message_remote_datasource.dart';
import '../models/message_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource messageRemoteDatasource;

  MessageRepositoryImpl({
    required this.messageRemoteDatasource,
  });

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId) async* {
    yield* messageRemoteDatasource
        .getMessages(conversationId)
        .asBroadcastStream();
  }

  @override
  Stream<Either<Failure, List<Conversation>>> getConversations(
      String userId) async* {
    yield* messageRemoteDatasource.getConversations(userId).asBroadcastStream();
  }

  @override
  Future<Either<Failure, String>> sendMessage(Message message) async {
    return messageRemoteDatasource
        .sendMessage(MessageModel.fromEntity(message));
  }

  @override
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId) async {
    return messageRemoteDatasource.updateReadStatus(userId, conversationId);
  }
}
