import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/update_user_bloc/update_user_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUpdateUserData mockUpdateUserData;
  late MockUpdatePersonalInformation mockUpdatePersonalInformation;
  late MockFormValidator mockFormValidator;
  late UpdateUserBloc bloc;

  setUp(
    () {
      mockUpdateUserData = MockUpdateUserData();
      mockUpdatePersonalInformation = MockUpdatePersonalInformation();
      mockFormValidator = MockFormValidator();
      bloc = UpdateUserBloc(
          updateUserData: mockUpdateUserData,
          formValidator: mockFormValidator,
          updatePersonalInformation: mockUpdatePersonalInformation);
    },
  );

  group('UpdateUserEvent', () {
    blocTest<UpdateUserBloc, UpdateUserState>(
      'emits [UpdateUserError] when data is invalid.',
      build: () {
        when(mockFormValidator.validate(
                username: tUser.username,
                displayName: tUser.displayName,
                email: tPersonalInformation.email,
                phoneNumber: tPersonalInformation.phoneNumber))
            .thenReturn(Left(InvalidInputFailure('invalid username')));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserEvent(
          user: tUser, personalInformation: tPersonalInformation)),
      expect: () => <UpdateUserState>[
        UpdateUserError.copyWith(errorMessage: 'invalid username')
      ],
      verify: (_) {
        mockFormValidator.validate(
            username: tUser.username,
            displayName: tUser.displayName,
            email: tPersonalInformation.email,
            phoneNumber: tPersonalInformation.phoneNumber);
        verifyNever(mockUpdateUserData(user: tUser));
        verifyNever(mockUpdatePersonalInformation(
            personalInformation: tPersonalInformation));
      },
    );

    group('When data is valid', () {
      setUp(
        () => when(mockFormValidator.validate(
                username: tUser.username,
                displayName: tUser.displayName,
                email: tPersonalInformation.email,
                phoneNumber: tPersonalInformation.phoneNumber))
            .thenReturn(Right(true)),
      );
      blocTest<UpdateUserBloc, UpdateUserState>(
        'emits [UpdateUserLoading,UpdateUserSuccess] when user data and personal information are updated successfully',
        build: () {
          when(mockUpdateUserData(user: tUser))
              .thenAnswer((_) async => Right('success'));
          when(mockUpdatePersonalInformation(
                  personalInformation: tPersonalInformation))
              .thenAnswer((_) async => Right('success'));
          return bloc;
        },
        act: (bloc) => bloc.add(UpdateUserEvent(
            user: tUser, personalInformation: tPersonalInformation)),
        expect: () => <UpdateUserState>[
          UpdateUserLoading(),
          UpdateUserSuccess(),
        ],
        verify: (_) {
          mockFormValidator.validate(
              username: tUser.username,
              displayName: tUser.displayName,
              email: tPersonalInformation.email,
              phoneNumber: tPersonalInformation.phoneNumber);
          mockUpdateUserData(user: tUser);
          mockUpdatePersonalInformation(
              personalInformation: tPersonalInformation);
        },
      );

      blocTest<UpdateUserBloc, UpdateUserState>(
        'emits [UpdateUserLoading,UpdateUserError] when updating user data and personal information fails',
        build: () {
          when(mockUpdateUserData(user: tUser))
              .thenAnswer((_) async => Left(PlatformFailure('')));
          when(mockUpdatePersonalInformation(
                  personalInformation: tPersonalInformation))
              .thenAnswer((_) async => Left(PlatformFailure('')));
          return bloc;
        },
        act: (bloc) => bloc.add(UpdateUserEvent(
            user: tUser, personalInformation: tPersonalInformation)),
        expect: () => <UpdateUserState>[
          UpdateUserLoading(),
          UpdateUserError.copyWith(errorMessage: 'Whoops something went wrong!')
        ],
        verify: (_) {
          mockFormValidator.validate(
              username: tUser.username,
              displayName: tUser.displayName,
              email: tPersonalInformation.email,
              phoneNumber: tPersonalInformation.phoneNumber);
          mockUpdateUserData(user: tUser);
          mockUpdatePersonalInformation(
              personalInformation: tPersonalInformation);
        },
      );
    });
  });
}
