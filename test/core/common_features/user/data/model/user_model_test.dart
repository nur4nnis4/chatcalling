import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';

void main() {
  test('UserModel Should be a subclass of User entity', () {
    // Assert
    expect(tUserModel, isA<User>());
  });

  test('fromJson Should return a valid model', () async {
    // Act
    final result = UserModel.fromJson(tUserJson);

    //Assert
    expect(result, tUserModel);
  });

  test('toJson Should retun JSON map containing proper data', () async {
    // Act
    final result = tUserModel.toJson();

    // Assert
    expect(result, tUserJson);
  });
}
