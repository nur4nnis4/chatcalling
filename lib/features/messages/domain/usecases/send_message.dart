import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:chatcalling/features/messages/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendMessage {
  final MessageRepository repository;
  SendMessage(this.repository);
  Future<Either<Failure, void>> call(Message message) {
    return repository.sendMessage(message);
  }
}
