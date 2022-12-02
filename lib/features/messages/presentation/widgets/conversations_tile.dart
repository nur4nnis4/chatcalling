import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/helpers/time.dart';
import '../../domain/entities/conversation.dart';
import '../pages/message_room_page.dart';
import '../../../../injector.dart';
import '../../../../l10n/l10n.dart';

import 'package:flutter/material.dart';

class LoadedConversationsTile extends StatelessWidget {
  final Conversation conversation;

  const LoadedConversationsTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    bool isBadgeVisible = conversation.totalUnreadMessages != 0 ? true : false;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageRoomPage(
                friendId: conversation.friendUser.userId,
                friendUser: conversation.friendUser,
              ),
            ));
      },
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 24,
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    foregroundImage:
                        NetworkImage(conversation.friendUser.profilePhotoUrl),
                  ),
                  Offstage(
                    offstage: !conversation.friendUser.isOnline,
                    child: Icon(
                      FontAwesomeIcons.solidCircle,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 7,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.friendUser.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Offstage(
                            offstage: conversation.friendUser.userId ==
                                conversation.lastMessage.senderId,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                  conversation.lastMessage.isRead
                                      ? FontAwesomeIcons.checkDouble
                                      : FontAwesomeIcons.check,
                                  size: 12,
                                  color: conversation.lastMessage.isRead
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          ),
                          Text(
                            conversation.lastMessage.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: conversation.totalUnreadMessages > 0
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
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
                        conversation.lastMessage.timeStamp,
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

class LoadingConversationsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 24,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 12,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Divider(
        color: Theme.of(context).dividerColor,
        thickness: 1,
        height: 0,
      )
    ]);
  }
}
