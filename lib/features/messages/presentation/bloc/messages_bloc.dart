import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_messages.dart';
import 'package:chatcalling/features/messages/domain/usecases/send_message.dart';
import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:chatcalling/features/messages/presentation/utils/message_input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final GetConversations getConversations;
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final UpdateReadStatus updateReadStatus;
  final MessageInputConverter messageInputConverter;

  MessagesBloc(
      {required this.getConversations,
      required this.getMessages,
      required this.sendMessage,
      required this.updateReadStatus,
      required this.messageInputConverter})
      : super(MessagesEmpty()) {
    // TODO : change the code below after FirebaseAUTH
    final userId = 'user1Id';

    on<MessagesEvent>((event, emit) async {
      // GetMessageEvent
      if (event is GetMessagesEvent) {
        emit(MessagesLoading());
        final result = getMessages(conversationId: event.conversationId)
            .asBroadcastStream();
        await emit.forEach(result,
            onData: (Either<Failure, List<Message>> data) {
          return data.fold((error) {
            return MessagesError(errorMessage: error.message);
          }, (messageList) {
            if (messageList.isEmpty)
              return MessagesEmpty();
            else
              return MessagesLoaded(messageList: messageList);
          });
        });
      }

      // GetConversationEvent
      else if (event is GetConversationsEvent) {
        emit(MessagesLoading());
        final result =
            getConversations(userId: event.userId).asBroadcastStream();
        await emit.forEach(result,
            onData: (Either<Failure, List<Conversation>> data) {
          return data.fold((error) {
            return MessagesError(errorMessage: error.message);
          }, (conversationList) {
            if (conversationList.isEmpty)
              return MessagesEmpty();
            else
              return ConversationsLoaded(conversationList: conversationList);
          });
        });
      }

      // SendMessageEvent
      else if (event is SendMessagesEvent) {
        emit(MessagesLoading());

        final result = await sendMessage(
            message: messageInputConverter.toMessage(
                event.text, userId, event.receiverId, event.attachmentPath));
        result.fold(
            (error) => emit(MessagesError(errorMessage: error.message)),
            (successMessage) =>
                emit(MessagesSuccess(successMessage: successMessage)));
      }

      // UpdateReadStatusEvent
      else if (event is UpdateReadStatusEvent) {
        emit(MessagesLoading());

        final result = await updateReadStatus(
            conversationId: event.conversationId, userId: userId);
        result.fold(
            (error) => emit(MessagesError(errorMessage: error.message)),
            (successMessage) =>
                emit(MessagesSuccess(successMessage: successMessage)));
      }
    });
  }
}
