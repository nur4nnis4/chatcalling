import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockSignInWithEmail mockSignInWithEmail;
  late MockSignInWithGoogle mockSignInWithGoogle;
  late SignInBloc bloc;

  setUp(
    () {
      mockSignInWithEmail = MockSignInWithEmail();
      mockSignInWithGoogle = MockSignInWithGoogle();
      bloc = SignInBloc(
          signInWithEmail: mockSignInWithEmail,
          signInWithGoogle: mockSignInWithGoogle);
    },
  );

  group('SignInWithEmailEvent', () {
    final tEmail = 'email@gmail.com';
    final tPassword = 'password';
    blocTest<SignInBloc, SignInState>(
        'should emit [SignInError] when email or password is empty.',
        build: () => bloc,
        act: (bloc) =>
            bloc.add(SignInWithEmailEvent(email: '', password: tPassword)),
        expect: () => [
              SignInError(
                  errorMessage: 'Email or password should not be empty'),
            ],
        verify: (_) =>
            verifyNever(mockSignInWithEmail(email: '', password: tPassword)));

    blocTest<SignInBloc, SignInState>(
        'should emit [SignInLoading,SignInSuccess] when sign in is successful.',
        build: () {
          when(mockSignInWithEmail(email: tEmail, password: tPassword))
              .thenAnswer((_) async => Right('Success'));
          return bloc;
        },
        act: (bloc) =>
            bloc.add(SignInWithEmailEvent(email: tEmail, password: tPassword)),
        expect: () => [
              SignInLoading(),
              SignInSuccess(),
            ],
        verify: (_) => mockSignInWithEmail(email: tEmail, password: tPassword));

    blocTest<SignInBloc, SignInState>(
        'should emit [SignInLoading,SignInError] when sign in fails.',
        build: () {
          when(mockSignInWithEmail(email: tEmail, password: tPassword))
              .thenAnswer((_) async =>
                  Left(PlatformFailure('Wrong email or password')));
          return bloc;
        },
        act: (bloc) =>
            bloc.add(SignInWithEmailEvent(email: tEmail, password: tPassword)),
        expect: () => [
              SignInLoading(),
              SignInError(errorMessage: 'Wrong email or password'),
            ],
        verify: (_) => mockSignInWithEmail(email: tEmail, password: tPassword));
  });

  group('SignInWithGoogleEvent', () {
    blocTest<SignInBloc, SignInState>(
        'should emit [SignInLoading,SignInSuccess] when sign in is successful.',
        build: () {
          when(mockSignInWithGoogle())
              .thenAnswer((_) async => Right('Success'));
          return bloc;
        },
        act: (bloc) => bloc.add(SignInWithGoogleEvent()),
        expect: () => [
              SignInLoading(),
              SignInSuccess(),
            ],
        verify: (_) => mockSignInWithGoogle());

    blocTest<SignInBloc, SignInState>(
        'should emit [SignInLoading,SignInError] when sign in fails.',
        build: () {
          when(mockSignInWithGoogle()).thenAnswer(
              (_) async => Left(PlatformFailure('Something went wrong')));
          return bloc;
        },
        act: (bloc) => bloc.add(SignInWithGoogleEvent()),
        expect: () => [
              SignInLoading(),
              SignInError(errorMessage: 'Something went wrong'),
            ],
        verify: (_) => mockSignInWithGoogle());
  });
}
