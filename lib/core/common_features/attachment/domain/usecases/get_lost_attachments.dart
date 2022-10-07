import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/core/common_features/attachment/domain/repositories/attachment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';

class GetLostAttachments {
  final AttachmentRepository repository;
  GetLostAttachments(this.repository);

  Future<Either<Failure, List<Attachment>>> call() async {
    return repository.getLostAttachments();
  }
}
