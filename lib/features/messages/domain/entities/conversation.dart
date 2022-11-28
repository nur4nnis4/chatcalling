import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Conversation extends Equatable {
  final String conversationId;
  final User friendUser;
  Message lastMessage;
  final int totalUnreadMessages;

  Conversation(
      {required this.conversationId,
      required this.friendUser,
      required this.lastMessage,
      required this.totalUnreadMessages});

  @override
  List<Object?> get props =>
      [conversationId, friendUser, lastMessage, totalUnreadMessages];
}
