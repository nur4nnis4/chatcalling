import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/get_messages.dart';

part 'message_list_event.dart';
part 'message_list_state.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  final GetMessages getMessages;
  final UniqueId uniqueId;
  final GetCurrentUserId getCurrentUserId;

  MessageListBloc({
    required this.getMessages,
    required this.uniqueId,
    required this.getCurrentUserId,
  }) : super(MessagesEmpty()) {
    on<GetMessagesEvent>((event, emit) async {
      final userId = await getCurrentUserId();

      emit(MessagesLoading());

      final conversationId = uniqueId.concat(event.friendId, userId);

      final result =
          getMessages(conversationId: conversationId).asBroadcastStream();
      await emit.forEach(result, onData: (Either<Failure, List<Message>> data) {
        return data.fold((error) {
          return MessagesError(errorMessage: error.message);
        }, (messageList) {
          if (messageList.isEmpty) {
            return MessagesEmpty();
          } else {
            return MessagesLoaded(messageList: messageList, userId: userId);
          }
        });
      });
    });
  }
}
