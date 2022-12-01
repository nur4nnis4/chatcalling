import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/friend_list_bloc/friend_list_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/user_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetFriendList mockGetFriendList;
  late FriendListBloc friendListBloc;

  final String tUserId = 'user1Id';

  setUp(() {
    mockGetFriendList = MockGetFriendList();
    friendListBloc = FriendListBloc(getFriendList: mockGetFriendList);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(friendListBloc.state, FriendListEmpty());
  });

  group('friendListEvent', () {
    blocTest<FriendListBloc, FriendListState>(
        'should emit [FriendListLoading,FriendListLoaded] when data is gotten successfully and is not empty.',
        build: () {
          when(mockGetFriendList(userId: tUserId)).thenAnswer((_) async* {
            yield Right([tUser]);
          });
          return friendListBloc;
        },
        act: (bloc) => bloc.add(GetFriendListEvent()),
        expect: () => [
              FriendListLoading(),
              FriendListLoaded(friendList: [tUser]),
            ],
        verify: (_) => verify(mockGetFriendList(userId: tUserId)));
    blocTest<FriendListBloc, FriendListState>(
        'emits [FriendListLoading, FriendListEmpty] when data is gotten successfully and is empty',
        build: () {
          when(mockGetFriendList(userId: tUserId)).thenAnswer((_) async* {
            yield Right([]);
          });
          return friendListBloc;
        },
        act: (bloc) => bloc.add(GetFriendListEvent()),
        expect: () => [
              FriendListLoading(),
              FriendListEmpty(),
            ],
        verify: (_) => verify(mockGetFriendList(userId: tUserId)));

    blocTest<FriendListBloc, FriendListState>(
        'emits [FriendListLoading, FriendListError] when getting data fails',
        build: () {
          when(mockGetFriendList(userId: tUserId)).thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });
          return friendListBloc;
        },
        act: (bloc) => bloc.add(GetFriendListEvent()),
        expect: () => [
              FriendListLoading(),
              FriendListError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockGetFriendList(userId: tUserId)));
  });
}
