import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/presentation/bloc/update_read_status_bloc/update_read_status_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUpdateReadStatus mockUpdateReadStatus;
  late MockGetCurrentUserId mockGetCurrentUserId;

  late MockUniqueId mockUniqueId;

  late UpdateReadStatusBloc bloc;

  final String tUserId = 'user1Id';
  final String tFriendId = 'user2Id';
  final String tConversationId = '$tUserId-$tFriendId';

  setUp(() {
    mockUpdateReadStatus = MockUpdateReadStatus();
    mockGetCurrentUserId = MockGetCurrentUserId();
    mockUniqueId = MockUniqueId();
    bloc = UpdateReadStatusBloc(
        updateReadStatus: mockUpdateReadStatus,
        uniqueId: mockUniqueId,
        getCurrentUserId: mockGetCurrentUserId);

    when(mockGetCurrentUserId()).thenAnswer((_) async => tUserId);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(bloc.state, UpdateReadStatusInitial());
  });

  group('updateReadStatusEvent', () {
    blocTest<UpdateReadStatusBloc, UpdateReadStatusState>(
      'should emit [UpdateReadStatusSuccess] when data is updated successfully.',
      build: () {
        when(mockUpdateReadStatus(
                conversationId: tConversationId, userId: tUserId))
            .thenAnswer((_) async => Right('Success'));
        when(mockUniqueId.concat(any, any)).thenReturn(tConversationId);
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateReadStatusEvent(tConversationId)),
      expect: () => [UpdateReadStatusSuccess()],
      verify: (bloc) => [
        mockUpdateReadStatus(conversationId: tConversationId, userId: tUserId),
        mockUniqueId.concat(tUserId, tFriendId),
      ],
    );
    blocTest<UpdateReadStatusBloc, UpdateReadStatusState>(
      'should emit [UpdateReadStatusError] when data is updated successfully.',
      build: () {
        when(mockUpdateReadStatus(
                conversationId: tConversationId, userId: tUserId))
            .thenAnswer((_) async => Left(PlatformFailure('')));
        when(mockUniqueId.concat(any, any)).thenReturn(tConversationId);
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateReadStatusEvent(tConversationId)),
      expect: () => [UpdateReadStatusError()],
      verify: (bloc) => [
        mockUpdateReadStatus(conversationId: tConversationId, userId: tUserId),
        mockUniqueId.concat(tUserId, tFriendId),
      ],
    );
  });
}
