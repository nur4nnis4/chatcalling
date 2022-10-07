import 'package:chatcalling/core/common_features/user/data/repositories/user_repository_impl.dart';
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

  group('getUserData', () {
    const String tUserId = 'user1Id';

    test('should return remote data', () async {
      // Arrange
      when(mockUserRemoteDatasource.getUserData(any)).thenAnswer((_) async* {
        yield Right(tUserModel);
      });
      // Act
      final result = repository.getUserData(tUserId).asBroadcastStream();
      // Assert
      result.listen((_) {
        verify(mockUserRemoteDatasource.getUserData(tUserId));
      });
      expect(result, emits(Right(tUserModel)));
    });
  });
}
