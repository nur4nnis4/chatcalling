import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/attachment/presentations/bloc/attachments_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/attachment_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockPickAttachments mockPickAttachments;
  late MockGetLostAttachments mockGetLostAttachments;
  late AttachmentsBloc attachmentsBloc;

  setUp(() {
    mockPickAttachments = MockPickAttachments();
    mockGetLostAttachments = MockGetLostAttachments();
    attachmentsBloc = AttachmentsBloc(
        pickAttachments: mockPickAttachments,
        getLostAttachments: mockGetLostAttachments);
  });

  group('AttachMultipleImageEvent', () {
    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsLoaded] when  data is gotten successfully.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.multipleImages))
            .thenAnswer((_) async => Right(tAttachmentModelList));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(AttachMultipleImagesEvent()),
      expect: () => <AttachmentsState>[
        AttachmentsLoaded(attachments: tAttachmentModelList)
      ],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.multipleImages)],
    );

    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsError] when getting data fails.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.multipleImages))
            .thenAnswer((_) async => Left(PluginFailure('')));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(AttachMultipleImagesEvent()),
      expect: () => <AttachmentsState>[AttachmentsError(errorMessage: '')],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.multipleImages)],
    );
  });

  group('TakeCameraImageEvent', () {
    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsLoaded] when  data is gotten successfully.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.cameraImage))
            .thenAnswer((_) async => Right(tAttachmentModelList));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(TakeCameraImageEvent()),
      expect: () => <AttachmentsState>[
        AttachmentsLoaded(attachments: tAttachmentModelList)
      ],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.cameraImage)],
    );

    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsError] when getting data fails.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.cameraImage))
            .thenAnswer((_) async => Left(PluginFailure('')));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(TakeCameraImageEvent()),
      expect: () => <AttachmentsState>[AttachmentsError(errorMessage: '')],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.cameraImage)],
    );
  });

  group('AttachVideoEvent', () {
    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsLoaded] when  data is gotten successfully.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.video))
            .thenAnswer((_) async => Right(tAttachmentModelList));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(AttachVideoEvent()),
      expect: () => <AttachmentsState>[
        AttachmentsLoaded(attachments: tAttachmentModelList)
      ],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.video)],
    );

    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsError] when getting data fails.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.video))
            .thenAnswer((_) async => Left(PluginFailure('')));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(AttachVideoEvent()),
      expect: () => <AttachmentsState>[AttachmentsError(errorMessage: '')],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.video)],
    );
  });

  group('TakeCameraVideoEvent', () {
    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsLoaded] when  data is gotten successfully.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.cameraVideo))
            .thenAnswer((_) async => Right(tAttachmentModelList));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(TakeCameraVideoEvent()),
      expect: () => <AttachmentsState>[
        AttachmentsLoaded(attachments: tAttachmentModelList)
      ],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.cameraVideo)],
    );

    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsError] when getting data fails.',
      build: () {
        when(mockPickAttachments(attachmentType: AttachmentType.cameraVideo))
            .thenAnswer((_) async => Left(PluginFailure('')));
        return attachmentsBloc;
      },
      act: (bloc) => bloc.add(TakeCameraVideoEvent()),
      expect: () => <AttachmentsState>[AttachmentsError(errorMessage: '')],
      verify: (bloc) =>
          [mockPickAttachments(attachmentType: AttachmentType.cameraVideo)],
    );
  });

  group('ResetAttachmentEvent', () {
    blocTest<AttachmentsBloc, AttachmentsState>(
      'emits [AttachmentsEmpty] when ResetAttachmentEvent is added',
      build: () => attachmentsBloc,
      act: (bloc) => bloc.add(ResetAttachmentEvent()),
      expect: () => <AttachmentsState>[AttachmentsEmpty()],
    );
  });
}
