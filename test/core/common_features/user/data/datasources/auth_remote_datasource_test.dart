import 'package:chatcalling/core/common_features/user/data/datasources/auth_remote_datasource.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRemoteDatasourceImpl dataSource;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockTime mockTime;
  late MockAuthErrorMessage mockAuthErrorMessage;

  setUp(() async {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockTime = MockTime();
    mockAuthErrorMessage = MockAuthErrorMessage();

    dataSource = AuthRemoteDatasourceImpl(
        firebaseAuth: mockFirebaseAuth,
        googleSignIn: mockGoogleSignIn,
        time: mockTime,
        authErrorMessage: mockAuthErrorMessage);
  });

  group('signUpWithEmail', () {
    test(' should create a new email auth provider ', () async {
      // Act
      await dataSource.signUpWithEmail('user2@gmail.com', '1234567890');
      final currentUserEmail = mockFirebaseAuth.currentUser!.email;

      // Assert
      expect(currentUserEmail, 'user2@gmail.com');
    });
  });

  group('signedInWithEmail', () {
    setUp(
      () async {
        await mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'user1@gmail.com', password: '1234567890');
        await mockFirebaseAuth.signOut();
      },
    );
    test('should sign user in to remote datasource', () async {
      // Act
      await dataSource.signInWithEmail('user1@gmail.com', '1234567890');
      // Assert
      final currentUserEmail = mockFirebaseAuth.currentUser!.email;
      expect(currentUserEmail, 'user1@gmail.com');
    });
  });

  // group('signInWithGoogle', () {
  //   test('Should sign user in to remote datasource', () async {
  //     when(mockTime.now()).thenReturn(DateTime(2022, 12, 5, 18, 47));
  //     // Act
  //     await dataSource.signInWithGoogle();

  //     // Assert
  //     final isSignedIn = mockFirebaseAuth.currentUser != null &&
  //         !mockFirebaseAuth.currentUser!.isAnonymous;
  //     expect(isSignedIn, true);
  //   });

  //   test('Should return userFullInfoModel', () async {
  //     when(mockTime.now()).thenReturn(DateTime(2022, 12, 5, 18, 47));
  //     // Act
  //     final userInfo = await dataSource.signInWithGoogle();
  //     // Assert
  //     expect(userInfo, isA<UserFullInfoModel>());
  //   });
  // });
}
