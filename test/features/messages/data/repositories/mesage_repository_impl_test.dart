import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/data/repositories/message_repository_impl.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/conversations_dummy.dart';
import '../../../../helpers/fixtures/message_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRemoteDatasource mockMessageRemoteDatasource;
  late MessageRepositoryImpl repository;

  setUp(() {
    mockMessageRemoteDatasource = MockMessageRemoteDatasource();

    repository = MessageRepositoryImpl(
      messageRemoteDatasource: mockMessageRemoteDatasource,
    );
  });

  group('getMessages', () {
    const String tConversationId = 'conversation1';
    final List<MessageModel> tMessageModelList = [tMessageModel];

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.getMessages(any)).thenAnswer((_) async* {
        yield tMessageModelList;
      });
      // Act
      final result =
          repository.getMessages(tConversationId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockMessageRemoteDatasource.getMessages(tConversationId));
      });
      expect(result, emits(Right(tMessageModelList)));
    });

    test(
        'should return platform failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.getMessages(any))
          .thenThrow(PlatformException());
      // Act
      final result =
          repository.getMessages(tConversationId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockMessageRemoteDatasource.getMessages(tConversationId));
      });
      expect(result, emits(Left(PlatformFailure(''))));
    });
  });

  group('getConversations', () {
    const String tUserId = 'user1Id';
    final List<ConversationModel> tConversationModelList = [tConversationModel];

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.getConversations(any))
          .thenAnswer((_) async* {
        yield tConversationModelList;
      });
      // Act
      final result = repository.getConversations(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
      });
      expect(result, emits(Right(tConversationModelList)));
    });
    test(
        'should return platform failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.getConversations(any))
          .thenThrow(PlatformException());
      // Act
      final result = repository.getConversations(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
      });
      expect(result, emits(Left(PlatformFailure(''))));
    });
  });

  group('sendMessage', () {
    test(
        'Should return success message when sending data to remote database is successful',
        () async {
      when(mockMessageRemoteDatasource.sendMessage(tMessageModel))
          .thenAnswer((_) async => '');
      // Act
      final result = await repository.sendMessage(tMessageModel);
      // Assert
      verify(mockMessageRemoteDatasource.sendMessage(tMessageModel));

      expect(result, Right('Message has been sent'));
    });
    test(
        'Should return platform failure when sending data to remote database is unsuccessful',
        () async {
      //Arrange
      when(mockMessageRemoteDatasource.sendMessage(tMessageModel))
          .thenThrow(PlatformException());
      // Act
      final result = await repository.sendMessage(tMessageModel);
      // Assert
      verify(mockMessageRemoteDatasource.sendMessage(tMessageModel));
      expect(result, Left(PlatformFailure('')));
    });
  });

  group('updateReadStatus', () {
    String tUserId = 'user1Id';
    String tConversationId = 'user1Id-user2Id';

    test(
        'Should return success message when sending data to remote database is successful',
        () async {
      when(mockMessageRemoteDatasource.updateReadStatus(
              tUserId, tConversationId))
          .thenAnswer((_) async => '');
      // Act
      final result =
          await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verify(mockMessageRemoteDatasource.updateReadStatus(
          tUserId, tConversationId));
      expect(result, Right('Message read status has been updated'));
    });
    test(
        'Should return platform failure when sending data to remote database is unsuccessful',
        () async {
      when(mockMessageRemoteDatasource.updateReadStatus(
              tUserId, tConversationId))
          .thenThrow(PlatformException());
      // Act
      final result =
          await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verify(mockMessageRemoteDatasource.updateReadStatus(
          tUserId, tConversationId));
      expect(result, Left(PlatformFailure('')));
    });
  });
}
