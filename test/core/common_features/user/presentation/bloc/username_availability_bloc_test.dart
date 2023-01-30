import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/username_availability_bloc/username_availability_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockCheckUsernameAvailability mockCheckUsernameAvailability;
  late UsernameAvailabilityBloc bloc;

  final String tNewUsername = 'newusername';
  final String tCurrentUsername = 'currentusername';

  setUp(() {
    mockCheckUsernameAvailability = MockCheckUsernameAvailability();
    bloc = UsernameAvailabilityBloc(
        checkUsernameAvailability: mockCheckUsernameAvailability);
  });

  test('Initial state should be UsernameInitial', () {
    // Assert
    expect(bloc.state, UsernameInitial());
  });

  group('CheckUsernameAvailabilityEvent', () {
    blocTest<UsernameAvailabilityBloc, UsernameAvailabilityState>(
      'emits [UsernameInitial] when newUsername is empty',
      build: () => bloc,
      act: (bloc) => bloc.add(CheckUsernameAvailabilityEvent(
          currentUsername: 'username', newUsername: '')),
      expect: () => [UsernameInitial()],
      verify: (_) => verifyNever(mockCheckUsernameAvailability(username: '')),
    );

    blocTest<UsernameAvailabilityBloc, UsernameAvailabilityState>(
      'emits [UsernameInitial] when currentUsername is equal to newUsername',
      build: () => bloc,
      act: (bloc) => bloc.add(CheckUsernameAvailabilityEvent(
          currentUsername: 'username', newUsername: 'username')),
      expect: () => [UsernameInitial()],
      verify: (_) =>
          verifyNever(mockCheckUsernameAvailability(username: 'username')),
    );

    blocTest<UsernameAvailabilityBloc, UsernameAvailabilityState>(
      'emits [UsernameLoading, UsernameAvailable] when username is available',
      build: () {
        when(mockCheckUsernameAvailability(username: tNewUsername))
            .thenAnswer((_) async {
          return Right(true);
        });
        return bloc;
      },
      act: (bloc) => bloc.add(CheckUsernameAvailabilityEvent(
          currentUsername: tCurrentUsername, newUsername: tNewUsername)),
      expect: () => [
        UsernameLoading(),
        UsernameAvailable(),
      ],
      verify: (_) => mockCheckUsernameAvailability(username: tNewUsername),
    );

    blocTest<UsernameAvailabilityBloc, UsernameAvailabilityState>(
        'emits [UsernameLoading, UsernameTaken] when username is already taken',
        build: () {
          when(mockCheckUsernameAvailability(username: tNewUsername))
              .thenAnswer((_) async {
            return Left(PlatformFailure('Username is already taken'));
          });
          return bloc;
        },
        act: (bloc) => bloc.add(CheckUsernameAvailabilityEvent(
            currentUsername: tCurrentUsername, newUsername: tNewUsername)),
        expect: () => [
              UsernameLoading(),
              UsernameTaken(message: 'Username is already taken'),
            ],
        verify: (_) =>
            verify(mockCheckUsernameAvailability(username: tNewUsername)));
  });
}
