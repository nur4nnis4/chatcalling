import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_status_bloc/sign_in_status_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockIsSignedIn mockIsSignedIn;
  late SignInStatusBloc bloc;

  setUp(
    () {
      mockIsSignedIn = MockIsSignedIn();
      bloc = SignInStatusBloc(isSignedIn: mockIsSignedIn);
    },
  );

  test('Should emit SignInStatusInitial as initial state', () {
    // Assert
    expect(bloc.state, SignInStatusInitial());
  });

  blocTest<SignInStatusBloc, SignInStatusState>(
      'should emit [SignInStatusTrue] when user is signed in',
      build: () {
        when(mockIsSignedIn()).thenAnswer((_) async* {
          yield true;
        });
        return bloc;
      },
      act: (bloc) => bloc.add(GetSignInStatusEvent()),
      expect: () => [
            SignInStatusTrue(),
          ],
      verify: (_) => mockIsSignedIn());

  blocTest<SignInStatusBloc, SignInStatusState>(
      'should emit [SignInStatusFalse] when user is not signed in.',
      build: () {
        when(mockIsSignedIn()).thenAnswer((_) async* {
          yield false;
        });
        return bloc;
      },
      act: (bloc) => bloc.add(GetSignInStatusEvent()),
      expect: () => [
            SignInStatusFalse(),
          ],
      verify: (_) => mockIsSignedIn());
}
