import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/data/repositories/message_repository_impl.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/dummy_objects.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRemoteDatasource mockMessageRemoteDatasource;
  late MockMessageLocalDatasource mockMessageLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late MessageRepositoryImpl repository;

  setUp(() {
    mockMessageRemoteDatasource = MockMessageRemoteDatasource();
    mockMessageLocalDatasource = MockMessageLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MessageRepositoryImpl(
      messageRemoteDatasource: mockMessageRemoteDatasource,
      messageLocalDatasource: mockMessageLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getMessages', () {
    const String tConversationId = 'conversation1';
    final List<MessageModel> tMessageModelList = [tMessageModel];

    final List<Message> tMessageList = tMessageModelList;
    test('Should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.getMessages(tConversationId))
          .thenAnswer((_) async => []);
      // Act
      await repository.getMessages(tConversationId);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('When the device is online', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getMessages(any))
            .thenAnswer((_) async => tMessageModelList);
        // Act
        final result = await repository.getMessages(tConversationId);
        // Assert
        verify(mockMessageRemoteDatasource.getMessages(tConversationId));
        expect(result, equals(Right(tMessageList)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getMessages(any))
            .thenAnswer((_) async => tMessageModelList);
        // Act
        await repository.getMessages(tConversationId);
        // Assert
        verify(mockMessageRemoteDatasource.getMessages(tConversationId));
        verify(mockMessageLocalDatasource.cacheMessages(tMessageModelList));
      });

      test(
          'should return ServerFailure when the call to remote data source is not successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getMessages(any))
            .thenThrow(ServerException());
        // Act
        final result = await repository.getMessages(tConversationId);
        // Assert
        verify(mockMessageRemoteDatasource.getMessages(tConversationId));
        verifyZeroInteractions(mockMessageLocalDatasource);
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
    group('When the device is offline', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return cached data when the cached data is present',
          () async {
        // Arrange
        when(mockMessageLocalDatasource.getMessages())
            .thenAnswer((_) async => tMessageModelList);
        // Act
        final result = await repository.getMessages(tConversationId);
        // Assert
        verify(mockMessageLocalDatasource.getMessages());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Right(tMessageList)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // Arrange
        when(mockMessageLocalDatasource.getMessages())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getMessages(tConversationId);
        // Assert
        verify(mockMessageLocalDatasource.getMessages());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Left(CacheFailure(''))));
      });
    });
  });
  group('getConversations', () {
    const String tUserId = 'userId';
    final tConversationModelList = [
      ConversationModel(
          conversationId: 'conversationId',
          contactId: 'contactId',
          lastText: 'lastText',
          lastMessageTime: DateTime.parse("2022-07-18 16:37:47.475845Z"),
          lastSenderId: 'lastSenderId',
          totalUnreadMessages: 1)
    ];
    final List<Conversation> tConversationList = tConversationModelList;

    test('Should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.getConversations(tUserId))
          .thenAnswer((_) async => []);
      // Act
      await repository.getConversations(tUserId);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('When the device is online', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getConversations(any))
            .thenAnswer((_) async => tConversationModelList);
        // Act
        final result = await repository.getConversations(tUserId);
        // Assert
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
        expect(result, equals(Right(tConversationList)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getConversations(any))
            .thenAnswer((_) async => tConversationModelList);
        // Act
        await repository.getConversations(tUserId);
        // Assert
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
        verify(mockMessageLocalDatasource
            .cacheConversations(tConversationModelList));
      });

      test(
          'should return ServerFailure when the call to remote data source is not successful',
          () async {
        // Arrange
        when(mockMessageRemoteDatasource.getConversations(any))
            .thenThrow(ServerException());
        // Act
        final result = await repository.getConversations(tUserId);
        // Assert
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
        verifyZeroInteractions(mockMessageLocalDatasource);
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
    group('When the device is offline', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return cached data when the cached data is present',
          () async {
        // // Arrange
        when(mockMessageLocalDatasource.getConversations())
            .thenAnswer((_) async => tConversationModelList);
        // Act
        final result = await repository.getConversations(tUserId);
        // Assert
        verify(mockMessageLocalDatasource.getConversations());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Right(tConversationList)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // Arrange
        when(mockMessageLocalDatasource.getConversations())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getConversations(tUserId);
        // Assert
        verify(mockMessageLocalDatasource.getConversations());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Left(CacheFailure(''))));
      });
    });
  });
}
