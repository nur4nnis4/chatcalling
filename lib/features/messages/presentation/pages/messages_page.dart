import 'package:chatcalling/core/widgets/custom_icon_button.dart';
import 'package:chatcalling/features/messages/presentation/widgets/conversations_tile.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        leading: SolidIconButton(
          icon: FontAwesomeIcons.magnifyingGlass,
          iconSize: 12,
        ),
        title: Text(L10n.of(context).message,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: CircleAvatar(
              maxRadius: 17,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              // TODO : fix Network Image url
              // foregroundImage: NetworkImage(
              //   '',
              // ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          itemCount: 14,
          itemBuilder: (_, index) => ConversationsTile(
              friendName: 'Haris Roundback',
              lastText: 'Wanna go outside?',
              lastMessageTime: "10:20",
              totalUnreadMessages: '1',
              friendPhotoUrl: ''),
        ),
      ),
    );
  }
}
