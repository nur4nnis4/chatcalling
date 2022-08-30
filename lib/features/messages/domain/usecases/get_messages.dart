import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class GetMessages {
  final MessageRepository repository;
  GetMessages(this.repository);

  Stream<Either<Failure, List<Message>>> call(
      {required String conversationId}) async* {
    yield* repository.getMessages(conversationId);
  }
}
