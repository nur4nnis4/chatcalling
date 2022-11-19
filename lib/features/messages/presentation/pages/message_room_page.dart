import 'dart:async';

import '../../../../core/common_widgets/custom_icon_button.dart';
import '../../domain/entities/conversation.dart';
import '../bloc/message_list_bloc.dart/message_list_bloc.dart';
import '../widgets/message_list_view.dart';
import '../widgets/send_message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageRoomPage extends StatefulWidget {
  final Conversation conversation;

  const MessageRoomPage({required this.conversation});

  @override
  State<MessageRoomPage> createState() => _MessageRoomPageState();
}

class _MessageRoomPageState extends State<MessageRoomPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MessageListBloc>(context, listen: false)
          .add(GetMessagesEvent(widget.conversation.conversationId));
      Provider.of<MessageListBloc>(context, listen: false)
          .add(UpdateReadStatusEvent(widget.conversation.conversationId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageListBloc, MessageListState>(
              builder: (context, messageListState) {
                if (messageListState is MessagesEmpty) {
                  return Container();
                } else if (messageListState is MessagesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (messageListState is MessagesError) {
                  return Container(
                    child: Text("OOPS! Something went wrong."),
                  );
                } else if (messageListState is MessagesLoaded) {
                  return MessageListView(
                      messageList: messageListState.messageList,
                      userId: messageListState.userId);
                } else {
                  return Center(
                    child: Text('Something went wrong...'),
                  );
                }
              },
            ),
          ),
          SendMessageBar(receiverId: widget.conversation.friendId),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
            child: SolidIconButton(
              onTap: () => Navigator.pop(context),
              icon: FontAwesomeIcons.angleLeft,
            ),
          ),
          CircleAvatar(
            maxRadius: 17,
            foregroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/chatcalling-63eb0.appspot.com/o/users%2Fmale-avatar.png?alt=media&token=67018152-17cc-4a70-a0c6-764679ce6acb"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haris Roundback',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          )
        ],
      ),
      actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimaryContainer),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Row(
            children: [
              OutlinedIconButton(icon: Icons.videocam),
              SizedBox(width: 6),
              OutlinedIconButton(icon: Icons.call),
            ],
          ),
        ),
      ],
    );
  }
}
