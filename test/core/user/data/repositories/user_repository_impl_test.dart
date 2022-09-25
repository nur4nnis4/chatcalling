import 'package:chatcalling/core/user/data/repositories/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/user_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRemoteDatasource mockUserRemoteDatasource;
  late MockUserLocalDatasource mockUserLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserRemoteDatasource = MockUserRemoteDatasource();
    mockUserLocalDatasource = MockUserLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      userRemoteDatasource: mockUserRemoteDatasource,
      userLocalDatasource: mockUserLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getUserData', () {
    const String tUserId = 'user1Id';
    test('Should check if the device is online', () async {
      // Arrange
      when(mockUserRemoteDatasource.getUserData(any)).thenAnswer((_) async* {
        yield Right(tUserModel);
      });
      when(mockUserLocalDatasource.cacheUserData(any))
          .thenAnswer((_) async => Right(''));
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      await repository.getUserData(tUserId).first;
      // // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('When the device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) async => Future.value(true));
        when(mockUserRemoteDatasource.getUserData(any)).thenAnswer((_) async* {
          yield Right(tUserModel);
        });
        when(mockUserLocalDatasource.cacheUserData(any))
            .thenAnswer((_) async => Right(''));
      });
      test('should return remote data', () async {
        // Act
        final result = repository.getUserData(tUserId).asBroadcastStream();
        // Assert
        result.listen((_) {
          verify(mockUserRemoteDatasource.getUserData(tUserId));
        });
        expect(result, emits(Right(tUserModel)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // Act
        final result = repository.getUserData(tUserId).asBroadcastStream();
        // Assert
        result.listen((_) {
          verify(mockUserRemoteDatasource.getUserData(tUserId));
          verify(mockUserLocalDatasource.cacheUserData(tUserModel));
        });
      });
    });
    group('When the device is offline', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return cached data when the cached data is present',
          () async {
        // Arrange
        when(mockUserLocalDatasource.getUserData())
            .thenAnswer((_) async => Right(tUserModel));
        // Act
        final result = await repository.getUserData(tUserId).first;
        // Assert
        verify(mockUserLocalDatasource.getUserData());
        verifyZeroInteractions(mockUserRemoteDatasource);
        expect(result, equals(Right(tUserModel)));
      });
    });
  });
}
