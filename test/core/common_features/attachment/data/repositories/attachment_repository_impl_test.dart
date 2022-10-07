import 'package:chatcalling/core/common_features/attachment/data/repositories/attachment_repository_impl.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/attachment_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockAttachmentLocalDatasource mockAttachmentLocalDatasource;
  late AttachmentRepositoryImpl repository;

  setUp(() {
    mockAttachmentLocalDatasource = MockAttachmentLocalDatasource();
    repository = AttachmentRepositoryImpl(
        attachmentLocalDatasource: mockAttachmentLocalDatasource);
  });
  group('PickAttachments', () {
    final List<Attachment> tAttachmentList = [tAttachment];
    test('When AttachmentType is image should call pickLocalImages', () async {
      // Arrange
      when(mockAttachmentLocalDatasource.pickLocalImages())
          .thenAnswer((_) async => Right(tAttachmentList));
      // Act
      await repository.pickAttachments(AttachmentType.multipleImages);
      // Assert
      verify(mockAttachmentLocalDatasource.pickLocalImages());
      verifyNever(mockAttachmentLocalDatasource.pickCameraImage());
      verifyNever(mockAttachmentLocalDatasource.pickLocalVideo());
      verifyNever(mockAttachmentLocalDatasource.pickCameraVideo());
    });
    test('When AttachmentType is cameraImage should call pickCameraImage',
        () async {
      // Arrange
      when(mockAttachmentLocalDatasource.pickCameraImage())
          .thenAnswer((_) async => Right(tAttachmentList));
      // Act
      await repository.pickAttachments(AttachmentType.cameraImage);
      // Assert
      verify(mockAttachmentLocalDatasource.pickCameraImage());
      verifyNever(mockAttachmentLocalDatasource.pickLocalImages());
      verifyNever(mockAttachmentLocalDatasource.pickLocalVideo());
      verifyNever(mockAttachmentLocalDatasource.pickCameraVideo());
    });
  });
}
