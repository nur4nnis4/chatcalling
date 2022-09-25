import 'package:chatcalling/core/widgets/custom_icon_button.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/presentation/bloc/message_list_bloc.dart/message_list_bloc.dart';
import 'package:chatcalling/features/messages/presentation/widgets/m_room_bottom_bar.dart';
import 'package:chatcalling/features/messages/presentation/widgets/message_bubble.dart';
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
              builder: (context, state) {
                if (state is MessagesEmpty) {
                  return Container();
                } else if (state is MessagesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MessagesError) {
                  return Container(
                    child: Text("ERROR : ${state.errorMessage}"),
                  );
                } else if (state is MessagesLoaded) {
                  final messageList = state.messageList;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: messageList.length,
                      itemBuilder: (_, index) => messageList[index].senderId ==
                              state.userId
                          ? SentMessageBubble(message: messageList[index])
                          : ReceivedMessageBubble(message: messageList[index]));
                } else {
                  return Center(
                    child: Text('Something went wrong...'),
                  );
                }
              },
            ),
          ),
          MRoomBottomBar(
            receiverId: widget.conversation.friendId,
          ),
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
