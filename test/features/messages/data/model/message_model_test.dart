import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/message_dummy.dart';

void main() {
  test('MessageModel should be a subclass of message entity ', () async {
    // Assert
    expect(tMessageModel, isA<Message>());
  });

  group('fromJson', () {
    test('Should return a valid model', () async {
      // Act
      final result = MessageModel.fromJson(tMessageJson);

      //Assert
      expect(result, tMessageModel);
    });
  });

  group('toJson', () {
    test('Should retun message JSON map containing proper data', () async {
      // Act
      final result = tMessageModel.toJson();

      // Assert
      expect(result, tMessageJson);
    });
  });

  group('toConversationJson', () {
    test('Should retun conversation JSON map containing proper data', () async {
      // Act
      final result = tMessageModel.toJson();

      // Assert
      expect(result, tMessageJson);
    });
  });
}
