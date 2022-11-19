import 'package:badges/badges.dart';
import '../../../../core/helpers/time.dart';
import '../../domain/entities/conversation.dart';
import '../pages/message_room_page.dart';
import '../../../../injector.dart';
import '../../../../l10n/l10n.dart';

import 'package:flutter/material.dart';

class ConversationsTile extends StatelessWidget {
  final Conversation conversation;

  const ConversationsTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    bool isBadgeVisible = conversation.totalUnreadMessages != 0 ? true : false;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageRoomPage(conversation: conversation),
            ));
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 24,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/chatcalling-63eb0.appspot.com/o/users%2Fmale-avatar.png?alt=media&token=67018152-17cc-4a70-a0c6-764679ce6acb"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // conversation.friendId,
                        "Haris Roundback",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                          conversation.friendId != conversation.lastSenderId
                              ? 'You: ${conversation.lastText}'
                              : conversation.lastText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: conversation.totalUnreadMessages > 0
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                              fontSize: 13,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sLocator.get<TimeFormat>().simplify(
                        conversation.lastMessageTime,
                        L10n.getLocalLanguageCode(context)),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: isBadgeVisible,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Badge(
                      toAnimate: false,
                      elevation: 0,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(45),
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      badgeColor: Theme.of(context).colorScheme.primary,
                      badgeContent: Text(
                        conversation.totalUnreadMessages.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          height: 0,
        )
      ]),
    );
  }
}
