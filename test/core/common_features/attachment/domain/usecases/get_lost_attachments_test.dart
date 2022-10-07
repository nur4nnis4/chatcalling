import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/get_lost_attachments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/attachment_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAttachmentRepository repository;
  late GetLostAttachments usecase;

  final List<Attachment> tAttachmentList = [tAttachment];

  setUp(() {
    repository = MockAttachmentRepository();
    usecase = GetLostAttachments(repository);
  });

  test('Should get lost attachment from the repository', () async {
    // Arrange
    when(repository.getLostAttachments())
        .thenAnswer((_) async => Right(tAttachmentList));
    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(tAttachmentList));
  });
}
