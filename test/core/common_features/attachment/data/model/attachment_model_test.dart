import 'package:chatcalling/core/common_features/attachment/data/models/attachment_model.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/fixtures/attachment_dummy.dart';

void main() {
  test('AttachmentModel should be a subclass of Attachment entity ', () async {
    // Assert
    expect(tAttachmentModel, isA<Attachment>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // Act
      final actual = AttachmentModel.fromJson(json: tAttachmentJson);

      //Assert
      expect(actual, tAttachmentModel);
    });
  });
  group('toJson', () {
    test("should retun JSON map containing proper data", () async {
      // Act
      final actual = tAttachmentModel.toJson();

      // Assert
      expect(actual, tAttachmentJson);
    });
  });

  group('fromEntity', () {
    test('should return a valid model', () async {
      // Act
      final actual = AttachmentModel.fromEntity(attachment: tAttachment);

      //Assert
      expect(actual, tAttachmentModel);
    });
  });
}
