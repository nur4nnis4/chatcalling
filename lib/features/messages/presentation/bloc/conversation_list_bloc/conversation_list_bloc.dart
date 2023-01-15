import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
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
  final GetCurrentUserId getCurrentUserId;

  ConversationListBloc(
      {required this.getConversations, required this.getCurrentUserId})
      : super(ConversationListEmpty()) {
    on<ConversationListEvent>((event, emit) async {
      emit(ConversationListLoading());
      final userId = await getCurrentUserId();
      final conversationListStream =
          getConversations(userId: userId).asBroadcastStream();

      await emit.forEach(conversationListStream,
          onData: (Either<Failure, List<Conversation>> data) {
        return data.fold((error) {
          return ConversationListError(errorMessage: error.message);
        }, (conversationList) {
          if (conversationList.isEmpty)
            return ConversationListEmpty();
          else {
            return ConversationListLoaded(
                conversationList: conversationList, userId: userId);
          }
        });
      });
    });
  }
}
