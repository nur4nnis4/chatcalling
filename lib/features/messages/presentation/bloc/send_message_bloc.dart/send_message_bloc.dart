import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc() : super(SendMessageInitial()) {
    on<SendMessageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
