import 'package:chatcalling/core/common_features/user/data/repositories/user_repository_impl.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRemoteDatasource mockUserRemoteDatasource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserRemoteDatasource = MockUserRemoteDatasource();
    repository = UserRepositoryImpl(
      userRemoteDatasource: mockUserRemoteDatasource,
    );
  });

  group('getFriendList', () {
    const String tUserId = 'user1Id';

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.getFriendList(any)).thenAnswer((_) async* {
        yield tUserModelList;
      });
      // Act
      final result = repository.getFriendList(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.getFriendList(tUserId));
      });
      expect(result, emits(Right(tUserModelList)));
    });
    test(
        'should return platform failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.getFriendList(any))
          .thenThrow(PlatformException());
      // Act
      final result = repository.getFriendList(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.getFriendList(tUserId));
      });
      expect(result, emits(Left(PlatformFailure(''))));
    });
  });

  group('searchUser', () {
    const String tQuery = 'Nur';

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.searchUser(any)).thenAnswer((_) async* {
        yield tUserModelList;
      });
      // Act
      final result = repository.searchUser(tQuery).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.searchUser(tQuery));
      });
      expect(result, emits(Right(tUserModelList)));
    });
    test(
        'should return platform failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.searchUser(any))
          .thenThrow(PlatformException());
      // Act
      final result = repository.searchUser(tQuery).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.searchUser(tQuery));
      });
      expect(result, emits(Left(PlatformFailure(''))));
    });
  });

  group('getUserData', () {
    const String tUserId = 'user1Id';

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.getUserData(any)).thenAnswer((_) async* {
        yield tUserModel;
      });
      // Act
      final result = repository.getUserData(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.getUserData(tUserId));
      });
      expect(result, emits(Right(tUserModel)));
    });
    test(
        'should return platform failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockUserRemoteDatasource.getUserData(any))
          .thenThrow(PlatformException());
      // Act
      final result = repository.getUserData(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.getUserData(tUserId));
      });
      expect(result, emits(Left(PlatformFailure(''))));
    });
  });
}
