import 'package:chatcalling/core/common_features/user/data/models/user_full_info_model.dart';
import 'package:chatcalling/core/common_features/user/data/repositories/auth_repository_impl.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRemoteDatasource mockUserRemoteDatasource;
  late MockAuthRemoteDatasource mockAuthRemoteDataSource;
  late AuthRepositoryImpl repository;

  final tEmail = 'user1@gmail.com';
  final tPassword = '1234567890';
  final tErrorMessage = 'some errorr';

  setUp(() {
    mockUserRemoteDatasource = MockUserRemoteDatasource();
    mockAuthRemoteDataSource = MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(
      userRemoteDatasource: mockUserRemoteDatasource,
      authRemoteDatasource: mockAuthRemoteDataSource,
    );
  });

  group('isSignedIn', () {
    test('Should get sign in status from remote data', () async {
      // Arrange
      when(mockAuthRemoteDataSource.isSignedIn()).thenAnswer((_) async* {
        yield true;
      });
      // Act
      final actual = repository.isSignedIn().asBroadcastStream();
      // Assert
      actual.listen((_) => verify(mockAuthRemoteDataSource.isSignedIn()));
      expect(actual, emits(true));
    });
  });

  group('signUpWithEmail', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      //Arrange
      when(mockAuthRemoteDataSource.getCurrentUserId())
          .thenAnswer((_) async => tNewUserModel.userId);

      // Act
      final result = await repository.signUpWithEmail(tNewUserWithoutUserId,
          tNewPersonalInformationWithoutUserId, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signUpWithEmail(
          tPersonalInformation.email, tPassword));
      verify(mockUserRemoteDatasource.addUserData(tNewUserModel));
      verify(mockUserRemoteDatasource
          .addPersonalInformation(tNewPersonalInformationModel));
      expect(result, Right('success'));
    });

    test(
        'should return PlatformFailure when the call to remote data source is unsuccessful',
        () async {
      //Assert
      when(mockAuthRemoteDataSource.signUpWithEmail(any, any))
          .thenThrow(PlatformException(message: tErrorMessage));
      // Act
      final result = await repository.signUpWithEmail(
          tUser, tPersonalInformation, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signUpWithEmail(
          tPersonalInformation.email, tPassword));
      expect(result, Left(PlatformFailure(tErrorMessage)));
    });
  });
  group('signInWithEmail', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signInWithEmail(tEmail, tPassword));
      expect(result, Right('success'));
    });

    test(
        'should return PlatformFailure when the call to remote data source is unsuccessful',
        () async {
      //Assert
      when(mockAuthRemoteDataSource.signInWithEmail(any, any))
          .thenThrow(PlatformException(message: tErrorMessage));
      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signInWithEmail(tEmail, tPassword));
      expect(result, Left(PlatformFailure(tErrorMessage)));
    });
  });

  group('signInWithEmail', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signInWithEmail(tEmail, tPassword));
      expect(result, Right('success'));
    });

    test(
        'should return PlatformFailure when the call to remote data source is unsuccessful',
        () async {
      //Assert
      when(mockAuthRemoteDataSource.signInWithEmail(any, any))
          .thenThrow(PlatformException(message: tErrorMessage));
      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);
      // Assert
      verify(mockAuthRemoteDataSource.signInWithEmail(tEmail, tPassword));
      expect(result, Left(PlatformFailure(tErrorMessage)));
    });
  });

  group('signInWithGoogle', () {
    group(
        'When the call to remote data source is successful and returns FullUserInfoModel',
        () {
      test('should return success message ', () async {
        when(mockAuthRemoteDataSource.signInWithGoogle()).thenAnswer(
            (_) async => UserFullInfoModel(
                user: tUserModel,
                personalInformation: tPersonalInformationModel));

        // Act
        final result = await repository.signInWithGoogle();

        // Assert
        verify(mockAuthRemoteDataSource.signInWithGoogle());
        verify(mockUserRemoteDatasource.addUserData(tUserModel));
        verify(mockUserRemoteDatasource
            .addPersonalInformation(tPersonalInformationModel));
        expect(result, Right('success'));
      });
    });

    group('When the call to remote data source is successful and returns null',
        () {
      test('should return success message ', () async {
        when(mockAuthRemoteDataSource.signInWithGoogle())
            .thenAnswer((_) async => null);

        // Act
        final result = await repository.signInWithGoogle();

        // Assert
        verify(mockAuthRemoteDataSource.signInWithGoogle());
        verifyNever(mockUserRemoteDatasource.addUserData(any));
        verifyNever(mockUserRemoteDatasource.addPersonalInformation(any));
        expect(result, Right('success'));
      });
    });

    test(
        'should return PlatformFailure when the call to remote data source is unsuccessful',
        () async {
      //Assert
      when(mockAuthRemoteDataSource.signInWithGoogle())
          .thenThrow(PlatformException(message: tErrorMessage));
      // Act
      final result = await repository.signInWithGoogle();
      // Assert
      verify(mockAuthRemoteDataSource.signInWithGoogle());
      expect(result, Left(PlatformFailure(tErrorMessage)));
    });
  });

  group('signOut', () {
    test(
        'should return success message when the call to remote data source is successful',
        () async {
      // Act
      final result = await repository.signOut();

      // Assert
      verify(mockAuthRemoteDataSource.signOut());
      expect(result, Right('success'));
    });

    test(
        'should return PlatformFailure when the call to remote data source is unsuccessful',
        () async {
      //Assert
      when(mockAuthRemoteDataSource.signOut())
          .thenThrow(PlatformException(message: tErrorMessage));
      // Act
      final result = await repository.signOut();
      // Assert
      verify(mockAuthRemoteDataSource.signOut());
      expect(result, Left(PlatformFailure(tErrorMessage)));
    });
  });
}
