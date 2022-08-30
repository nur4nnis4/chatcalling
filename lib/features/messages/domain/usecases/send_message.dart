import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessage {
  final MessageRepository repository;
  SendMessage(this.repository);

  Future<Either<Failure, String>> call({required Message message}) async {
    return repository.sendMessage(message);
  }
}
