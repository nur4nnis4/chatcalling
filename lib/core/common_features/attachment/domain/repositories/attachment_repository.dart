import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AttachmentRepository {
  Future<Either<Failure, List<Attachment>>> pickAttachments(
      AttachmentType attachmentType);
  Future<Either<Failure, List<Attachment>>> getLostAttachments();
}
