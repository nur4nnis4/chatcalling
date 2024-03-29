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
  late MockGetCurrentUserId mockGetCurrentUserId;

  late MockUniqueId mockUniqueId;

  late MessageListBloc messagesBloc;

  final String tUserId = 'user1Id';
  final String tFriendId = 'user2Id';
  final String tConversationId = '$tUserId-$tFriendId';

  setUp(() {
    mockGetMessages = MockGetMessages();
    mockGetCurrentUserId = MockGetCurrentUserId();
    mockUniqueId = MockUniqueId();
    messagesBloc = MessageListBloc(
        getMessages: mockGetMessages,
        uniqueId: mockUniqueId,
        getCurrentUserId: mockGetCurrentUserId);

    when(mockGetCurrentUserId()).thenAnswer((_) async => tUserId);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(messagesBloc.state, MessagesEmpty());
  });

  group('getMessagesEvent', () {
    setUp(() {
      when(mockUniqueId.concat(any, any)).thenReturn(tConversationId);
    });
    blocTest<MessageListBloc, MessageListState>(
        'should emit [MessagesLoading,MessagesLoaded] when data is gotten successfully and is not empty.',
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
        verify: (_) => [
              mockGetMessages(conversationId: tConversationId),
              mockUniqueId.concat(tUserId, tFriendId),
            ]);
    blocTest<MessageListBloc, MessageListState>(
        'emits [MessagesLoading, MessagesEmpty] when data is gotten successfully and is empty',
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
        verify: (_) => [
              mockGetMessages(conversationId: tConversationId),
              mockUniqueId.concat(tUserId, tFriendId),
            ]);

    blocTest<MessageListBloc, MessageListState>(
        'emits [MessagesLoading, MessagesError] when getting data fails',
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
        verify: (_) => [
              mockGetMessages(conversationId: tConversationId),
              mockUniqueId.concat(tUserId, tFriendId),
            ]);
  });
}
