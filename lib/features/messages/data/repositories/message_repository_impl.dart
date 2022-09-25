import 'dart:async';

import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/features/messages/data/datasources/message_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource messageRemoteDatasource;
  final MessageLocalDatasource messageLocalDatasource;

  MessageRepositoryImpl({
    required this.messageRemoteDatasource,
    required this.messageLocalDatasource,
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
    // TODO : FIX networkinfo (Device has connection is True but return false)
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
