import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/helpers/temp.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/usecases/get_conversations.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc
    extends Bloc<ConversationListEvent, ConversationListState> {
  final GetConversations getConversations;

  ConversationListBloc({required this.getConversations})
      : super(ConversationListEmpty()) {
    on<ConversationListEvent>((event, emit) async {
      emit(ConversationListLoading());
      final conversationListStream =
          getConversations(userId: Temp.userId).asBroadcastStream();

      await emit.forEach(conversationListStream,
          onData: (Either<Failure, List<Conversation>> data) {
        return data.fold((error) {
          return ConversationListError(errorMessage: error.message);
        }, (conversationList) {
          if (conversationList.isEmpty)
            return ConversationListEmpty();
          else {
            return ConversationListLoaded(
                conversationList: conversationList, userId: Temp.userId);
          }
        });
      });
    });
  }
}
