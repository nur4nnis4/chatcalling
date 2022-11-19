import '../entities/attachment.dart';
import '../repositories/attachment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';

class PickAttachments {
  final AttachmentRepository repository;
  PickAttachments(this.repository);

  Future<Either<Failure, List<Attachment>>> call(
      {required AttachmentType attachmentType}) async {
    return repository.pickAttachments(attachmentType);
  }
}
