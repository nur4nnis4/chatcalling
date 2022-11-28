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
  Stream<Either<Failure, List<Message>>> getMessages(
      String conversationId) async* {
    try {
      yield* messageRemoteDatasource
          .getMessages(conversationId)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Stream<Either<Failure, List<Conversation>>> getConversations(
      String userId) async* {
    try {
      yield* messageRemoteDatasource
          .getConversations(userId)
          .map((event) => Right(event));
    } catch (e) {
      yield Left(PlatformFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(Message message) async {
    try {
      await messageRemoteDatasource
          .sendMessage(MessageModel.fromEntity(message));
      return Right('Message has been sent');
    } catch (e) {
      return Left(PlatformFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId) async {
    try {
      await messageRemoteDatasource.updateReadStatus(userId, conversationId);
      return Right('Message read status has been updated');
    } catch (e) {
      return Left(PlatformFailure(''));
    }
  }
}
