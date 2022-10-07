import 'package:bloc/bloc.dart';
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

  MessageListBloc({
    required this.getMessages,
    required this.updateReadStatus,
  }) : super(MessagesEmpty()) {
    // TODO : change the code below after FirebaseAUTH
    final String _userId = 'user1Id';

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

      // UpdateReadStatusEvent
      else if (event is UpdateReadStatusEvent) {
        await updateReadStatus(
            conversationId: event.conversationId, userId: _userId);
      }
    });
  }
}
