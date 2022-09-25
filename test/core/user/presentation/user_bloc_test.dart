import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/core/user/presentation/bloc/bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/fixtures/user_dummy.dart';
import '../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetUserData mockGetUserData;
  late UserBloc userBloc;

  final String tUserId = 'user1Id';

  setUp(() {
    mockGetUserData = MockGetUserData();

    userBloc = UserBloc(
      getUserData: mockGetUserData,
    );
  });

  test('Initial state should be empty', () {
    // Assert
    expect(userBloc.state, UserEmpty());
  });

  group('getUserDataEvent', () {
    blocTest<UserBloc, UserState>(
        'should emit [Loading,UserLoaded] when data is gotten succesfully.',
        build: () {
          when(mockGetUserData(userId: tUserId)).thenAnswer((_) async* {
            yield Right(tUser);
          });
          return userBloc;
        },
        act: (bloc) => bloc.add(GetUserDataEvent(tUserId)),
        expect: () => [
              UserLoading(),
              UserLoaded(userData: tUser),
            ],
        verify: (_) => verify(mockGetUserData(userId: tUserId)));

    blocTest<UserBloc, UserState>(
        'emits [Loading, Error] when getting data fails',
        build: () {
          when(mockGetUserData(userId: tUserId)).thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });
          return userBloc;
        },
        act: (bloc) => bloc.add(GetUserDataEvent(tUserId)),
        expect: () => [
              UserLoading(),
              UserError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockGetUserData(userId: tUserId)));
  });
}
