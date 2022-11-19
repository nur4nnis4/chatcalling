import '../datasources/attachment_local_datasource.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/repositories/attachment_repository.dart';
import '../../../../error/failures.dart';
import 'package:dartz/dartz.dart';

class AttachmentRepositoryImpl extends AttachmentRepository {
  final AttachmentLocalDatasource attachmentLocalDatasource;

  AttachmentRepositoryImpl({
    required this.attachmentLocalDatasource,
  });

  @override
  Future<Either<Failure, List<Attachment>>> pickAttachments(
      AttachmentType attachmentType) async {
    if (attachmentType == AttachmentType.multipleImages)
      return attachmentLocalDatasource.pickLocalImages();
    else
      return attachmentLocalDatasource.pickCameraImage();
  }

  @override
  Future<Either<Failure, List<Attachment>>> getLostAttachments() {
    // TODO: implement getLostAttachment
    throw UnimplementedError();
  }
}
