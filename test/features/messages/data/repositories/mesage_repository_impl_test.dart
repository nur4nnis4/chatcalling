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
  late MockMessageLocalDatasource mockMessageLocalDatasource;
  late MessageRepositoryImpl repository;

  setUp(() {
    mockMessageRemoteDatasource = MockMessageRemoteDatasource();
    mockMessageLocalDatasource = MockMessageLocalDatasource();

    repository = MessageRepositoryImpl(
      messageRemoteDatasource: mockMessageRemoteDatasource,
      messageLocalDatasource: mockMessageLocalDatasource,
    );
  });

  group('getMessages', () {
    const String tConversationId = 'conversation1';
    final List<MessageModel> tMessageModelList = [tMessageModel];

    test('should return remote data', () async {
      // Arrange
      when(mockMessageRemoteDatasource.getMessages(any)).thenAnswer((_) async* {
        yield Right(tMessageModelList);
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
  });

  group('getConversations', () {
    const String tUserId = 'user1Id';
    final List<ConversationModel> tConversationModelList = [tConversationModel];

    test('should return remote data', () async {
      // Arrange
      when(mockMessageRemoteDatasource.getConversations(any))
          .thenAnswer((_) async* {
        yield Right(tConversationModelList);
      });
      // Act
      final result = repository.getConversations(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockMessageRemoteDatasource.getConversations(tUserId));
      });
      expect(result, emits(Right(tConversationModelList)));
    });
  });

  group('sendMessage', () {
    test('When the device is online should send data to remote database',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.sendMessage(tMessageModel))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.sendMessage(tMessageModel);
      // Assert
      verify(mockMessageRemoteDatasource.sendMessage(tMessageModel));
    });
  });

  group('updateReadStatus', () {
    String tUserId = 'user1Id';
    String tConversationId = 'user1Id-user2Id';

    test(
        'When the device is online should update messages read status in remote database',
        () async {
      // Arrange
      when(mockMessageRemoteDatasource.updateReadStatus(
              tUserId, tConversationId))
          .thenAnswer((_) async => Right(''));
      // Act
      await repository.updateReadStatus(tUserId, tConversationId);
      // Assert
      verify(mockMessageRemoteDatasource.updateReadStatus(
          tUserId, tConversationId));
    });
  });
}
