import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/message_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetMessages mockGetMessages;
  late MockUpdateReadStatus mockUpdateReadStatus;

  late MessageListBloc messagesBloc;

  final String tConversationId = 'user1Id-user2Id';
  final String tUserId = 'user1Id';

  setUp(() {
    mockGetMessages = MockGetMessages();
    mockUpdateReadStatus = MockUpdateReadStatus();
    messagesBloc = MessageListBloc(
      getMessages: mockGetMessages,
      updateReadStatus: mockUpdateReadStatus,
    );
  });

  test('Initial state should be empty', () {
    // Assert
    expect(messagesBloc.state, MessagesEmpty());
  });

  group('getMessagesEvent', () {
    blocTest<MessageListBloc, MessageListState>(
        'should emit [Loading,MessagesLoaded] when data is gotten successfully and is not empty.',
        build: () {
          when(mockGetMessages(conversationId: tConversationId))
              .thenAnswer((_) async* {
            yield Right([tMessage]);
          });
          return messagesBloc;
        },
        act: (bloc) => bloc.add(GetMessagesEvent(tConversationId)),
        expect: () => [
              MessagesLoading(),
              MessagesLoaded(messageList: [tMessage], userId: tUserId),
            ],
        verify: (_) =>
            verify(mockGetMessages(conversationId: tConversationId)));
    blocTest<MessageListBloc, MessageListState>(
        'emits [Loading, Empty] when data is gotten successfully and is empty',
        build: () {
          when(mockGetMessages(conversationId: tConversationId))
              .thenAnswer((_) async* {
            yield Right([]);
          });
          return messagesBloc;
        },
        act: (bloc) => bloc.add(GetMessagesEvent(tConversationId)),
        expect: () => [
              MessagesLoading(),
              MessagesEmpty(),
            ],
        verify: (_) =>
            verify(mockGetMessages(conversationId: tConversationId)));

    blocTest<MessageListBloc, MessageListState>(
        'emits [Loading, Error] when getting data fails',
        build: () {
          when(mockGetMessages(conversationId: tConversationId))
              .thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });
          return messagesBloc;
        },
        act: (bloc) => bloc.add(GetMessagesEvent(tConversationId)),
        expect: () => [
              MessagesLoading(),
              MessagesError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) =>
            verify(mockGetMessages(conversationId: tConversationId)));
  });

  group('updateReadStatusEvent', () {
    blocTest<MessageListBloc, MessageListState>(
      'Should call UpdateReadStatus usecase   ',
      build: () {
        when(mockUpdateReadStatus(
                conversationId: tConversationId, userId: tUserId))
            .thenAnswer((_) async => Right('Success'));
        return messagesBloc;
      },
      act: (bloc) => bloc.add(UpdateReadStatusEvent(tConversationId)),
      verify: (bloc) => mockUpdateReadStatus(
          conversationId: tConversationId, userId: tUserId),
    );
  });
}
