part of 'send_message_bloc.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();
  
  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}
