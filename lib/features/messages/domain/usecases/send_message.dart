import '../../../../core/error/failures.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessage {
  final MessageRepository repository;
  SendMessage(this.repository);

  Future<Either<Failure, String>> call({required Message message}) async {
    return repository.sendMessage(message);
  }
}
