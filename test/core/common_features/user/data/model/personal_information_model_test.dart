import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';

void main() {
  test(
      'PersonalInfomationModel Should be a subclass of PersonalInformation entity',
      () {
    // Assert
    expect(tPersonalInformationModel, isA<PersonalInformation>());
  });

  group('fromJson', () {
    test('Should return a valid model', () async {
      // Act
      final result =
          PersonalInformationModel.fromJson(tPersonalInformationJson);

      //Assert
      expect(result, tPersonalInformationModel);
    });
    test('Should return a valid model when dateOfBirth is empty', () async {
      // Act
      final result =
          PersonalInformationModel.fromJson(tPersonalInformationJsonEmptyDOB);

      //Assert
      expect(result, tPersonalInformationModelNullDOB);
    });
  });

  group('toJson', () {
    test('Should retun JSON map containing proper data', () async {
      // Act
      final result = tPersonalInformationModel.toJson();

      // Assert
      expect(result, tPersonalInformationJson);
    });

    test(
        'Should retun JSON map containing proper data when dateOfBirth is null',
        () async {
      // Act
      final result = tPersonalInformationModelNullDOB.toJson();

      // Assert
      expect(result, tPersonalInformationJsonEmptyDOB);
    });
  });
}
