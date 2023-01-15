import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/presentation/bloc/conversation_list_bloc/conversation_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/conversations_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetConversations mockGetConversations;
  late MockGetCurrentUserId mockGetCurrentUserId;
  late ConversationListBloc conversationListBloc;
  final String tUserId = 'user1Id';

  setUp(() {
    mockGetConversations = MockGetConversations();
    mockGetCurrentUserId = MockGetCurrentUserId();
    conversationListBloc = ConversationListBloc(
        getConversations: mockGetConversations,
        getCurrentUserId: mockGetCurrentUserId);

    when(mockGetCurrentUserId()).thenAnswer((_) async => tUserId);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(conversationListBloc.state, ConversationListEmpty());
  });

  group('getConversationsEvent', () {
    blocTest<ConversationListBloc, ConversationListState>(
        'should emit [ConversationListLoading,ConversationListLoaded] when data is gotten successfully and is not empty.',
        build: () {
          when(mockGetConversations(userId: tUserId)).thenAnswer((_) async* {
            yield Right([tConversation]);
          });

          return conversationListBloc;
        },
        act: (bloc) => bloc.add(ConversationListEvent()),
        expect: () => [
              ConversationListLoading(),
              ConversationListLoaded(
                  conversationList: [tConversation], userId: tUserId),
            ],
        verify: (_) => verify(mockGetConversations(userId: tUserId)));
    blocTest<ConversationListBloc, ConversationListState>(
        'emits [ConversationListLoading, ConversationListEmpty] when data is gotten successfully and is empty',
        build: () {
          when(mockGetConversations(userId: tUserId)).thenAnswer((_) async* {
            yield Right([]);
          });

          return conversationListBloc;
        },
        act: (bloc) => bloc.add(ConversationListEvent()),
        expect: () => [
              ConversationListLoading(),
              ConversationListEmpty(),
            ],
        verify: (_) => verify(mockGetConversations(userId: tUserId)));

    blocTest<ConversationListBloc, ConversationListState>(
        'emits [ConversationListLoading, ConversationListError] when getting data fails',
        build: () {
          when(mockGetConversations(userId: tUserId)).thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });

          return conversationListBloc;
        },
        act: (bloc) => bloc.add(ConversationListEvent()),
        expect: () => [
              ConversationListLoading(),
              ConversationListError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockGetConversations(userId: tUserId)));
  });
}
