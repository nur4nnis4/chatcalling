import 'dart:async';

import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/other_user_bloc/other_user_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/profile_page.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/injector.dart';
import 'package:chatcalling/l10n/l10n.dart';

import '../../../../core/common_widgets/custom_icon_button.dart';
import '../bloc/message_list_bloc.dart/message_list_bloc.dart';
import '../widgets/message_list_view.dart';
import '../widgets/send_message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageRoomPage extends StatefulWidget {
  final String friendId;
  final User friendUser;

  const MessageRoomPage({
    required this.friendId,
    required this.friendUser,
  });

  @override
  State<MessageRoomPage> createState() => _MessageRoomPageState();
}

class _MessageRoomPageState extends State<MessageRoomPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MessageListBloc>(context, listen: false)
          .add(GetMessagesEvent(widget.friendId));
      Provider.of<MessageListBloc>(context, listen: false)
          .add(UpdateReadStatusEvent(widget.friendId));
      BlocProvider.of<OtherUserBloc>(context)
          .add(GetOtherUserEvent(userId: widget.friendUser.userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(widget.friendUser),
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
                } else if (messageListState is MessagesLoaded) {
                  return MessageListView(
                      messageList: messageListState.messageList,
                      userId: messageListState.userId);
                } else {
                  return Center(
                    child: Text("OOPS! Something went wrong."),
                  );
                }
              },
            ),
          ),
          SendMessageBar(receiverId: widget.friendId),
        ],
      ),
    );
  }

  AppBar _buildAppBar(User friendUser) {
    late User user;
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      title: BlocBuilder<OtherUserBloc, OtherUserState>(
        builder: (context, state) {
          if (state is OtherUserLoaded) {
            user = state.userData;
          } else {
            user = friendUser;
          }
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
                child: SolidIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: FontAwesomeIcons.angleLeft,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(user: user))),
                child: CircleAvatar(
                  maxRadius: 17,
                  foregroundImage: NetworkImage(friendUser.profilePhotoUrl),
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      user.isOnline
                          ? 'Online'
                          : '${L10n.of(context).lastSeen} ${sLocator.get<TimeFormat>().simplify(user.lastOnline, L10n.getLocalLanguageCode(context))}',
                      style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              )
            ],
          );
        },
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
