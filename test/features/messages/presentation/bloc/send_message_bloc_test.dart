import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/message_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockSendMessage mockSendMessage;
  late MockMessageInputConverter mockMessageInputConverter;
  late SendMessageBloc sendMessageBloc;

  setUp(() {
    mockSendMessage = MockSendMessage();
    mockMessageInputConverter = MockMessageInputConverter();
    sendMessageBloc = SendMessageBloc(
        sendMessage: mockSendMessage,
        messageInputConverter: mockMessageInputConverter);
    when(mockMessageInputConverter.toMessage(
            text: tMessage.text,
            userId: tMessage.senderId,
            receiverId: tMessage.receiverId,
            attachments: tMessage.attachments))
        .thenReturn(tMessage);
  });
  blocTest<SendMessageBloc, SendMessageState>(
    'emits [Loading, MessagesSucces] when message is sent successfully.',
    build: () {
      when(mockSendMessage(message: tMessage))
          .thenAnswer((_) async => Right('Success'));
      return sendMessageBloc;
    },
    act: (bloc) => bloc.add(SendMessageEvent(
        text: tMessage.text,
        receiverId: tMessage.receiverId,
        attachments: tMessage.attachments)),
    expect: () => <SendMessageState>[
      SendMessageLoading(message: MessageModel.fromEntity(tMessage)),
      SendMessageSuccess(successMessage: 'Success')
    ],
    verify: (_) {
      mockSendMessage(message: tMessage);
      mockMessageInputConverter.toMessage(
          text: tMessage.text,
          userId: tMessage.senderId,
          receiverId: tMessage.receiverId,
          attachments: tMessage.attachments);
    },
  );

  blocTest<SendMessageBloc, SendMessageState>(
    'emits [Loading, MessageSucces] when sending message fails.',
    build: () {
      when(mockSendMessage(message: tMessage))
          .thenAnswer((_) async => Left(PlatformFailure('PlatformFailure')));

      return sendMessageBloc;
    },
    act: (bloc) => bloc.add(SendMessageEvent(
        text: tMessage.text,
        receiverId: tMessage.receiverId,
        attachments: tMessage.attachments)),
    expect: () => <SendMessageState>[
      SendMessageLoading(message: MessageModel.fromEntity(tMessage)),
      SendMessageError(errorMessage: 'PlatformFailure')
    ],
    verify: (_) {
      mockSendMessage(message: tMessage);
      mockMessageInputConverter.toMessage(
          text: tMessage.text,
          userId: tMessage.senderId,
          receiverId: tMessage.receiverId,
          attachments: tMessage.attachments);
    },
  );
}
