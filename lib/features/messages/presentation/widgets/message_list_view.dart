import 'package:chatcalling/features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/time.dart';
import '../../domain/entities/message.dart';
import 'message_bubble.dart';
import '../../../../injector.dart';
import '../../../../l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class MessageListView extends StatefulWidget {
  final List<Message> messageList;
  final String userId;
  const MessageListView(
      {Key? key, required this.messageList, required this.userId})
      : super(key: key);

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageBloc, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageLoading &&
            widget.messageList.first.text != state.message.text) {
          widget.messageList.insert(0, state.message);
        }
      },
      builder: (context, state) {
        return GroupedListView<Message, DateTime>(
            floatingHeader: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            reverse: true,
            sort: false,
            padding: const EdgeInsets.all(10),
            elements: widget.messageList,
            groupBy: (message) =>
                sLocator.get<TimeFormat>().toYMD(message.timeStamp),
            groupSeparatorBuilder: (date) => _listviewSeparator(date),
            itemBuilder: (_, message) => message.senderId == widget.userId
                ? SentMessageBubble(
                    message: message,
                    sentStatus:
                        message.messageId != widget.messageList[0].messageId
                            ? MessageSentStatus.sent
                            : state is SendMessageLoading
                                ? MessageSentStatus.sending
                                : state is SendMessageError
                                    ? MessageSentStatus.failed
                                    : MessageSentStatus.sent)
                : ReceivedMessageBubble(message: message));
      },
    );
  }

  Padding _listviewSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            child: Text(
              sLocator
                  .get<TimeFormat>()
                  .yMMMMd(date, L10n.getLocalLanguageCode(context)),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withAlpha(200)),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withAlpha(200),
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}
