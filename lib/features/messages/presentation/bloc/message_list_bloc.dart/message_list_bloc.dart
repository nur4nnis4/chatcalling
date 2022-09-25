import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_conversations.dart';
import '../../../domain/usecases/get_messages.dart';
import '../../../domain/usecases/send_message.dart';
import '../../../domain/usecases/update_read_status.dart';
import '../../utils/message_input_converter.dart';

part 'message_list_event.dart';
part 'message_list_state.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  final GetConversations getConversations;
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final UpdateReadStatus updateReadStatus;
  final MessageInputConverter messageInputConverter;

  MessageListBloc(
      {required this.getConversations,
      required this.getMessages,
      required this.sendMessage,
      required this.updateReadStatus,
      required this.messageInputConverter})
      : super(MessagesEmpty()) {
    // TODO : change the code below after FirebaseAUTH
    final String _userId = 'user2Id';

    on<MessageListEvent>((event, emit) async {
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
              return MessagesLoaded(messageList: messageList, userId: _userId);
          });
        });
      }

      // SendMessageEvent
      else if (event is SendMessagesEvent) {
        final result = await sendMessage(
            message: messageInputConverter.toMessage(
                event.text, _userId, event.receiverId, event.attachmentPath));
        // result.fold(
        //     (error) => emit(MessagesError(errorMessage: error.message)),
        //     (successMessage) =>
        //         emit(MessagesSuccess(successMessage: successMessage)));
      }

      // UpdateReadStatusEvent
      else if (event is UpdateReadStatusEvent) {
        final result = await updateReadStatus(
            conversationId: event.conversationId, userId: _userId);
        // result.fold(
        //     (error) => emit(MessagesError(errorMessage: error.message)),
        //     (successMessage) =>
        //         emit(MessagesSuccess(successMessage: successMessage)));
      }
    });
  }
}
