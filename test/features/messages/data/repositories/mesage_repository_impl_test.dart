import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/data/repositories/message_repository_impl.dart';

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

    test('Should check if the device is online', () async {
      // Arrange
      when(mockMessageRemoteDatasource.getMessages(any)).thenAnswer((_) async* {
        yield Right([]);
      });
      when(mockMessageLocalDatasource.cacheMessages(any))
          .thenAnswer((_) async => Right(''));
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getMessages(tConversationId).first;
      // // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('When the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        when(mockMessageRemoteDatasource.getMessages(any))
            .thenAnswer((_) async* {
          yield Right(tMessageModelList);
        });
        when(mockMessageLocalDatasource.cacheMessages(any))
            .thenAnswer((_) async => Right(''));
      });
      test('should return remote data', () async {
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
          'should cache data locally when the call to remote data source is successful',
          () async {
        // Act
        final result =
            repository.getMessages(tConversationId).asBroadcastStream();
        // Assert
        result.listen((_) {
          verify(mockMessageRemoteDatasource.getMessages(tConversationId));
          verify(mockMessageLocalDatasource.cacheMessages(tMessageModelList));
        });
      });
    });
    group('When the device is offline', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return cached data when the cached data is present',
          () async {
        // Arrange
        when(mockMessageLocalDatasource.getMessages())
            .thenAnswer((_) async => Right(tMessageModelList));
        // Act
        final result = await repository.getMessages(tConversationId).first;
        // Assert
        verify(mockMessageLocalDatasource.getMessages());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Right(tMessageModelList)));
      });
    });
  });
  group('getConversations', () {
    const String tUserId = 'user1Id';
    final List<ConversationModel> tConversationModelList = [tConversationModel];

    test('Should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.getConversations(any))
          .thenAnswer((_) async* {
        yield Right([]);
      });
      when(mockMessageLocalDatasource.cacheConversations(any))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.getConversations(tUserId).first;
      // // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('When the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        when(mockMessageRemoteDatasource.getConversations(any))
            .thenAnswer((_) async* {
          yield Right(tConversationModelList);
        });
        when(mockMessageLocalDatasource.cacheConversations(any))
            .thenAnswer((_) async => Right(''));
      });
      test('should return remote data', () async {
        // Act
        final result = repository.getConversations(tUserId).asBroadcastStream();
        // Assert
        result.listen((_) {
          verify(mockMessageRemoteDatasource.getConversations(tUserId));
        });
        expect(result, emits(Right(tConversationModelList)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // Act
        final result = repository.getConversations(tUserId).asBroadcastStream();
        // Assert
        result.listen((_) {
          verify(mockMessageRemoteDatasource.getConversations(tUserId));
          verify(mockMessageLocalDatasource
              .cacheConversations(tConversationModelList));
        });
      });
    });
    group('When the device is offline', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return cached data when the cached data is present',
          () async {
        // Arrange
        when(mockMessageLocalDatasource.getConversations())
            .thenAnswer((_) async => Right(tConversationModelList));
        // Act
        final result = await repository.getConversations(tUserId).first;
        // Assert
        verify(mockMessageLocalDatasource.getConversations());
        verifyZeroInteractions(mockMessageRemoteDatasource);
        expect(result, equals(Right(tConversationModelList)));
      });
    });
  });
  group('sendMessage', () {
    test('Should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.sendMessage(tMessageModel))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.sendMessage(tMessageModel);
      // // Assert
      verify(mockNetworkInfo.isConnected);
    });
    test('When the device is online should send data to remote database',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.sendMessage(tMessageModel))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.sendMessage(tMessageModel);
      // Assert
      verify(mockMessageRemoteDatasource.sendMessage(tMessageModel));
    });

    test('When the device is offline should return Connection failure',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // Act
      final result = await repository.sendMessage(tMessageModel);
      // Assert
      verifyNever(mockMessageRemoteDatasource.sendMessage(tMessageModel));
      expect(result, Left(ConnectionFailure('')));
    });
  });

  group('updateReadStatus', () {
    String tUserId = 'user1Id';
    String tConversationId = 'user1Id-user2Id';
    test('Should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.updateReadStatus(
              tUserId, tConversationId))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });
    test(
        'When the device is online should update messages read status in remote database',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMessageRemoteDatasource.updateReadStatus(
              tUserId, tConversationId))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verify(mockMessageRemoteDatasource.updateReadStatus(
          tUserId, tConversationId));
    });

    test('When the device is offline should return Connection failure',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // Act
      final result =
          await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verifyNever(mockMessageRemoteDatasource.updateReadStatus(
          tUserId, tConversationId));
      expect(result, Left(ConnectionFailure('')));
    });
  });
}
