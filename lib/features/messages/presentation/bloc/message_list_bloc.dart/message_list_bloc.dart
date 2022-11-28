import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/helpers/temp.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_messages.dart';
import '../../../domain/usecases/update_read_status.dart';

part 'message_list_event.dart';
part 'message_list_state.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  final GetMessages getMessages;
  final UpdateReadStatus updateReadStatus;
  final UniqueId uniqueId;

  MessageListBloc({
    required this.getMessages,
    required this.updateReadStatus,
    required this.uniqueId,
  }) : super(MessagesEmpty()) {
    on<MessageListEvent>((event, emit) async {
      // GetMessageEvent
      if (event is GetMessagesEvent) {
        emit(MessagesLoading());
        final conversationId = uniqueId.concat(event.friendId, Temp.userId);

        final result =
            getMessages(conversationId: conversationId).asBroadcastStream();
        await emit.forEach(result,
            onData: (Either<Failure, List<Message>> data) {
          return data.fold((error) {
            return MessagesError(errorMessage: error.message);
          }, (messageList) {
            if (messageList.isEmpty)
              return MessagesEmpty();
            else
              return MessagesLoaded(
                  messageList: messageList, userId: Temp.userId);
          });
        });
      }

      // UpdateReadStatusEvent
      else if (event is UpdateReadStatusEvent) {
        final conversationId = uniqueId.concat(event.friendId, Temp.userId);

        await updateReadStatus(
            conversationId: conversationId, userId: Temp.userId);
      }
    });
  }
}
