import '../entities/attachment.dart';
import '../../../../error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AttachmentRepository {
  Future<Either<Failure, List<Attachment>>> pickAttachments(
      AttachmentType attachmentType);
  Future<Either<Failure, List<Attachment>>> getLostAttachments();
}
