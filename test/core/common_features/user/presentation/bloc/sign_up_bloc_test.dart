import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockSignUpWithEmail mockSignUpWithEmail;
  late MockCheckUsernameAvailability mockCheckUsernameAvailability;
  late MockFormValidator mockFormValidator;
  late MockUserInputConverter mockUserInputConverter;
  late SignUpBloc bloc;

  setUp(
    () {
      mockSignUpWithEmail = MockSignUpWithEmail();
      mockCheckUsernameAvailability = MockCheckUsernameAvailability();
      mockFormValidator = MockFormValidator();
      mockUserInputConverter = MockUserInputConverter();
      bloc = SignUpBloc(
          signUpWithEmail: mockSignUpWithEmail,
          userInputConverter: mockUserInputConverter,
          formValidator: mockFormValidator,
          checkUsernameAvailability: mockCheckUsernameAvailability);
    },
  );

  final tPassword = 'password';

  group('SignUpEvent', () {
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpWithEmailError] when data is invalid.',
      build: () {
        when(mockFormValidator.validate(
                username: tUser.username,
                displayName: tUser.displayName,
                email: tPersonalInformation.email,
                password: tPassword))
            .thenReturn(Left(InvalidInputFailure('invalid username')));
        return bloc;
      },
      act: (bloc) => bloc.add(SignUpWithEmailEvent(
          displayName: tUser.displayName,
          email: tPersonalInformation.email,
          password: tPassword,
          username: tUser.username)),
      expect: () => <SignUpState>[
        SignUpWithEmailError.copyWith(errorMessage: 'invalid username')
      ],
      verify: (_) {
        mockFormValidator.validate(
            username: tUser.username,
            displayName: tUser.displayName,
            email: tPersonalInformation.email,
            password: tPassword);
      },
    );

    group('When data is valid', () {
      setUp(
        () => when(mockFormValidator.validate(
                username: tUser.username,
                displayName: tUser.displayName,
                email: tPersonalInformation.email,
                password: tPassword))
            .thenReturn(Right(true)),
      );
      blocTest<SignUpBloc, SignUpState>(
        'emits [SignUpWithEmailLoading,SignUpWithEmailError] when username is not available',
        build: () {
          when(mockCheckUsernameAvailability(username: tUser.username))
              .thenAnswer((_) async =>
                  Left(PlatformFailure('Username is already taken')));
          return bloc;
        },
        act: (bloc) => bloc.add(SignUpWithEmailEvent(
            displayName: tUser.displayName,
            email: tPersonalInformation.email,
            password: tPassword,
            username: tUser.username)),
        expect: () => <SignUpState>[
          SignUpWithEmailLoading(),
          SignUpWithEmailError.copyWith(
              errorMessage: 'Username is already taken')
        ],
        verify: (_) {
          mockFormValidator.validate(
              username: tUser.username,
              displayName: tUser.displayName,
              email: tPersonalInformation.email,
              password: tPassword);
          mockCheckUsernameAvailability(username: tUser.username);
        },
      );

      group('and when username is available ', () {
        setUp(
          () {
            when(mockCheckUsernameAvailability(username: tUser.username))
                .thenAnswer((_) async => Right(true));
            when(mockUserInputConverter.toUser(
                    displayName: tUser.displayName, username: tUser.username))
                .thenReturn(tUser);
            when(mockUserInputConverter.toPersonalInformation(
                    email: tPersonalInformation.email))
                .thenReturn(tPersonalInformation);
          },
        );

        blocTest<SignUpBloc, SignUpState>(
          'emits [SignUpWithEmailLoading, SignUpWithEmailError] when sign up fails.',
          build: () {
            when(mockSignUpWithEmail(
                    personalInformation: tPersonalInformation,
                    user: tUser,
                    password: tPassword))
                .thenAnswer((_) async =>
                    Left(PlatformFailure('email is already taken')));
            return bloc;
          },
          act: (bloc) => bloc.add(SignUpWithEmailEvent(
              displayName: tUser.displayName,
              email: tPersonalInformation.email,
              password: tPassword,
              username: tUser.username)),
          expect: () => <SignUpState>[
            SignUpWithEmailLoading(),
            SignUpWithEmailError.copyWith(
                errorMessage: 'email is already taken')
          ],
          verify: (_) {
            mockSignUpWithEmail(
                personalInformation: tPersonalInformation,
                user: tUser,
                password: tPassword);
            mockUserInputConverter.toUser(
                displayName: tUser.displayName, username: tUser.username);
            mockUserInputConverter.toPersonalInformation(
                email: tPersonalInformation.email);
          },
        );

        blocTest<SignUpBloc, SignUpState>(
          'emits [SignUpWithEmailLoading, SignUpWithEmailSuccess] when sign up is successful.',
          build: () {
            when(mockSignUpWithEmail(
                    personalInformation: tPersonalInformation,
                    user: tUser,
                    password: tPassword))
                .thenAnswer((_) async => Right('Success'));
            return bloc;
          },
          act: (bloc) => bloc.add(SignUpWithEmailEvent(
              displayName: tUser.displayName,
              email: tPersonalInformation.email,
              password: tPassword,
              username: tUser.username)),
          expect: () =>
              <SignUpState>[SignUpWithEmailLoading(), SignUpWithEmailSuccess()],
          verify: (_) {
            mockSignUpWithEmail(
                personalInformation: tPersonalInformation,
                user: tUser,
                password: tPassword);
            mockUserInputConverter.toUser(
                displayName: tUser.displayName, username: tUser.username);
            mockUserInputConverter.toPersonalInformation(
                email: tPersonalInformation.email);
          },
        );
      });
    });
  });
}
