import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetUserData mockGetUserData;
  late UserBloc userBloc;
  late MockGetCurrentUserId mockGetCurrentUserId;

  final String tUserId = 'user1Id';

  setUp(() {
    mockGetUserData = MockGetUserData();
    mockGetCurrentUserId = MockGetCurrentUserId();

    userBloc = UserBloc(
      getUserData: mockGetUserData,
      getCurrentUserId: mockGetCurrentUserId,
    );

    when(mockGetCurrentUserId()).thenAnswer((_) async => tUserId);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(userBloc.state, UserEmpty());
  });

  group('getUserDataEvent', () {
    blocTest<UserBloc, UserState>(
        'should emit [UserLoading,UserLoaded] when data is gotten succesfully.',
        build: () {
          when(mockGetUserData(userId: tUserId)).thenAnswer((_) async* {
            yield Right(tUser);
          });

          return userBloc;
        },
        act: (bloc) => bloc.add(GetUserEvent()),
        expect: () => [
              UserLoading(),
              UserLoaded(userData: tUser),
            ],
        verify: (_) => verify(mockGetUserData(userId: tUserId)));

    blocTest<UserBloc, UserState>(
        'emits [UserLoading, UserError] when getting data fails',
        build: () {
          when(mockGetUserData(userId: tUserId)).thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });

          return userBloc;
        },
        act: (bloc) => bloc.add(GetUserEvent()),
        expect: () => [
              UserLoading(),
              UserError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockGetUserData(userId: tUserId)));
  });
}
