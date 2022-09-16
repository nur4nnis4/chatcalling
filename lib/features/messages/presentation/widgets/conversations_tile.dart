import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ConversationsTile extends StatelessWidget {
  final String friendName;
  final String lastText;
  final String friendPhotoUrl;
  final String lastMessageTime;
  final String totalUnreadMessages;

  const ConversationsTile(
      {Key? key,
      required this.friendName,
      required this.lastText,
      required this.friendPhotoUrl,
      required this.lastMessageTime,
      required this.totalUnreadMessages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBadgeVisible = totalUnreadMessages != '0' ? true : false;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
                maxRadius: 20,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundImage: friendPhotoUrl.isNotEmpty
                    ? NetworkImage(
                        friendPhotoUrl,
                      )
                    : null),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friendName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(lastText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 11,
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
                  lastMessageTime.toUpperCase(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                  ),
                ),
                SizedBox(height: 6),
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
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    badgeColor: Theme.of(context).colorScheme.primary,
                    badgeContent: Text(
                      totalUnreadMessages,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 8),
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
    ]);
  }
}
