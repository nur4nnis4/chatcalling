import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockGetPersonalInformation mockGetPersonalInformation;
  late PersonalInformationBloc personalInformationBloc;

  final String tUserId = 'user1Id';

  setUp(() {
    mockGetPersonalInformation = MockGetPersonalInformation();

    personalInformationBloc = PersonalInformationBloc(
      getPersonalInformation: mockGetPersonalInformation,
    );
  });

  test('Initial state should be empty', () {
    // Assert
    expect(personalInformationBloc.state, PersonalInformationEmpty());
  });

  group('getPersonalInformationEvent', () {
    blocTest<PersonalInformationBloc, PersonalInformationState>(
        'should emit [PersonalInformationLoading,PersonalInformationLoaded] when data is gotten succesfully.',
        build: () {
          when(mockGetPersonalInformation(userId: tUserId))
              .thenAnswer((_) async* {
            yield Right(tPersonalInformation);
          });
          return personalInformationBloc;
        },
        act: (bloc) => bloc.add(PersonalInformationEvent()),
        expect: () => [
              PersonalInformationLoading(),
              PersonalInformationLoaded(
                  personalInformation: tPersonalInformation),
            ],
        verify: (_) => verify(mockGetPersonalInformation(userId: tUserId)));

    blocTest<PersonalInformationBloc, PersonalInformationState>(
        'emits [PersonalInformationLoading, PersonalInformationError] when getting data fails',
        build: () {
          when(mockGetPersonalInformation(userId: tUserId))
              .thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });
          return personalInformationBloc;
        },
        act: (bloc) => bloc.add(PersonalInformationEvent()),
        expect: () => [
              PersonalInformationLoading(),
              PersonalInformationError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockGetPersonalInformation(userId: tUserId)));
  });
}
