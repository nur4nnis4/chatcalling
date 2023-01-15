import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockSignOut mockSignOut;
  late SignOutBloc bloc;

  setUp(
    () {
      mockSignOut = MockSignOut();
      bloc = SignOutBloc(signOut: mockSignOut);
    },
  );

  blocTest<SignOutBloc, SignOutState>(
      'should emit [SignOutLoading,SignOutSuccess] when sign out is successful.',
      build: () {
        when(mockSignOut()).thenAnswer((_) async => Right('Success'));
        return bloc;
      },
      act: (bloc) => bloc.add(SignOutEvent()),
      expect: () => [
            SignOutLoading(),
            SignOutSuccess(),
          ],
      verify: (_) => mockSignOut());

  blocTest<SignOutBloc, SignOutState>(
      'should emit [SignOutLoading,SignOutError] when sign out fails.',
      build: () {
        when(mockSignOut()).thenAnswer((_) async => Left(PlatformFailure('')));
        return bloc;
      },
      act: (bloc) => bloc.add(SignOutEvent()),
      expect: () => [
            SignOutLoading(),
            SignOutError(errorMessage: 'Oops something went wrong!'),
          ],
      verify: (_) => mockSignOut());
}
