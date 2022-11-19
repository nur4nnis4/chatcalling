import 'package:bloc/bloc.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import '../../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../../../domain/usecases/send_message.dart';
import '../../utils/message_input_converter.dart';
import 'package:equatable/equatable.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final SendMessage sendMessage;
  final MessageInputConverter messageInputConverter;

  // TODO : change the code below after FirebaseAUTH
  final String _userId = 'user1Id';

  SendMessageBloc(
      {required this.sendMessage, required this.messageInputConverter})
      : super(SendMessageInitial()) {
    on<SendMessageEvent>((event, emit) async {
      final message = messageInputConverter.toMessage(
          text: event.text,
          userId: _userId,
          receiverId: event.receiverId,
          attachments: event.attachments);
      emit(SendMessageLoading(message: MessageModel.fromEntity(message)));

      final result = await sendMessage(message: message);
      result.fold(
          (error) => emit(SendMessageError(errorMessage: error.message)),
          (successMessage) =>
              emit(SendMessageSuccess(successMessage: successMessage)));
    });
  }
}
