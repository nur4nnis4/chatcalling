import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc
    extends Bloc<ConversationListEvent, ConversationListState> {
  final GetConversations getConversations;

// TODO : change the code below after FirebaseAUTH
  final String _userId = 'user1Id';

  ConversationListBloc({required this.getConversations})
      : super(ConversationListEmpty()) {
    on<ConversationListEvent>((event, emit) async {
      emit(ConversationListLoading());
      final result = getConversations(userId: _userId).asBroadcastStream();
      await emit.forEach(result,
          onData: (Either<Failure, List<Conversation>> data) {
        return data.fold((error) {
          return ConversationListError(errorMessage: error.message);
        }, (conversationList) {
          if (conversationList.isEmpty)
            return ConversationListEmpty();
          else
            return ConversationListLoaded(
                conversationList: conversationList, userId: _userId);
        });
      });
    });
  }
}
