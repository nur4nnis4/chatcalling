import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/network/network_info.dart';
import 'package:chatcalling/features/messages/data/datasources/message_local_datasource.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
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
  Future<Either<Failure, List<Message>>> getMessages(
      String conversationId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMessageList =
            await messageRemoteDatasource.getMessages(conversationId);
        await messageLocalDatasource.cacheMessages(remoteMessageList);
        return Right(remoteMessageList);
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final localMessageList = await messageLocalDatasource.getMessages();
        return Right(localMessageList);
      } on CacheException {
        return Left(CacheFailure(''));
      }
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations(
      String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteConversationList =
            await messageRemoteDatasource.getConversations(userId);
        await messageLocalDatasource.cacheConversations(remoteConversationList);
        return Right(remoteConversationList);
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final localConversationList =
            await messageLocalDatasource.getConversations();
        return Right(localConversationList);
      } on CacheException {
        return Left(CacheFailure(''));
      }
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(Message message) async {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
