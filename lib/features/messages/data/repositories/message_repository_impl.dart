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
  final NetworkInfo networkInfo;

  MessageRepositoryImpl(
      {required this.messageRemoteDatasource,
      required this.messageLocalDatasource,
      required this.networkInfo});

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId) async* {
    if (await networkInfo.isConnected) {
      final messageListStream = messageRemoteDatasource
          .getMessages(conversationId)
          .asBroadcastStream();
      messageListStream.listen((event) {
        if (event.isRight())
          messageLocalDatasource.cacheMessages(event.getOrElse(() => []));
      });
      yield* messageListStream;
    } else
      yield await messageLocalDatasource.getMessages();
  }

  @override
  Stream<Either<Failure, List<Conversation>>> getConversations(
      String userId) async* {
    if (await networkInfo.isConnected) {
      final conversationListStream =
          messageRemoteDatasource.getConversations(userId).asBroadcastStream();
      conversationListStream.listen((event) {
        if (event.isRight())
          messageLocalDatasource.cacheConversations(event.getOrElse(() => []));
      });
      yield* conversationListStream;
    } else
      yield await messageLocalDatasource.getConversations();
  }

  @override
  Future<Either<Failure, String>> sendMessage(Message message) async {
    if (await networkInfo.isConnected)
      return messageRemoteDatasource
          .sendMessage(MessageModel.fromEntity(message));
    else
      return Left(ConnectionFailure(''));
  }

  @override
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId) async {
    if (await networkInfo.isConnected) {
      return messageRemoteDatasource.updateReadStatus(userId, conversationId);
    } else
      return Left(ConnectionFailure(''));
  }
}
