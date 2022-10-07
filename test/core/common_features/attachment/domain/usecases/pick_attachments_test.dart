import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/attachment/domain/usecases/pick_attachments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/attachment_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAttachmentRepository repository;
  late PickAttachments usecase;

  final List<Attachment> tAttachmentList = [tAttachment];

  setUp(() {
    repository = MockAttachmentRepository();
    usecase = PickAttachments(repository);
  });

  test('Should pick attachment from the repository', () async {
    // Arrange
    when(repository.pickAttachments(any))
        .thenAnswer((_) async => Right(tAttachmentList));
    // Act
    final result = await usecase(attachmentType: AttachmentType.multipleImages);

    // Assert
    expect(result, Right(tAttachmentList));
  });
}
