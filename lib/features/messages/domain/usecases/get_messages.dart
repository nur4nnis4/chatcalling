import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class GetMessages {
  final MessageRepository repository;
  GetMessages(this.repository);

  Future<Either<Failure, List<Message>>> call(
      {required String conversationId}) async {
    return await repository.getMessages(conversationId);
  }
}
