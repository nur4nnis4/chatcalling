import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';

void main() {
  test('UserModel Should be a subclass of User entity', () {
    // Assert
    expect(tUserModel, isA<User>());
  });

  group('fromJson', () {
    test('Should return a valid model', () async {
      // Act
      final result = UserModel.fromJson(tUserJson);

      //Assert
      expect(result, tUserModel);
    });
  });
  group('toJson', () {
    test(
        'Should retun JSON map containing proper data when signUpTime and lastOnline is UTC',
        () async {
      // Act
      final result = tUserModel.toJson();

      // Assert
      expect(result, tUserJson);
    });
    test(
        'Should retun JSON map containing proper data when signUpTime and lastOnline is not UTC',
        () async {
      // Act
      final result = tUserModelNotUTC.toJson();

      // Assert
      expect(result, tUserJson);
    });
  });
}
