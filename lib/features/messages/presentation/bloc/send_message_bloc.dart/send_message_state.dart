part of 'send_message_bloc.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {
  final MessageModel message;

  SendMessageLoading({required this.message});
}

class SendMessageSuccess extends SendMessageState {
  final String successMessage;

  SendMessageSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class SendMessageError extends SendMessageState {
  final String errorMessage;

  SendMessageError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
