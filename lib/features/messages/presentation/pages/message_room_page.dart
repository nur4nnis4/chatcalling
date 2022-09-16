import 'package:chatcalling/core/widgets/custom_icon_button.dart';
import 'package:chatcalling/core/widgets/radiating_action_button.dart';
import 'package:chatcalling/features/messages/presentation/widgets/message_bubble.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageRoomPage extends StatefulWidget {
  const MessageRoomPage({Key? key}) : super(key: key);

  @override
  State<MessageRoomPage> createState() => _MessageRoomPageState();
}

class _MessageRoomPageState extends State<MessageRoomPage> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.addListener(() => (setState(() {})));
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        titleSpacing: 0,
        leading: SolidIconButton(
          icon: FontAwesomeIcons.angleLeft,
        ),
        title: Row(
          children: [
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
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                        fontSize: 9,
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                SentMessageBubble(
                    message: 'You know how it goes. You know how it goes.'),
                ReceivedMessageBubble(message: 'Yeah'),
              ],
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: _bottomBar(),
          ))
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return Card(
      elevation: 0.0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            _iconButton(icon: FontAwesomeIcons.faceSmile),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                  controller: textEditingController,
                  maxLines: 6,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      border: InputBorder.none,
                      hintText: L10n.of(context).typeSomething + '...',
                      contentPadding: EdgeInsets.all(0))),
            ),
            _iconButtonVisibility(icon: FontAwesomeIcons.image),
            _iconButtonVisibility(icon: FontAwesomeIcons.paperclip),
            SizedBox(width: 10),
            textEditingController.text.isEmpty
                ? RadiatingActionButton(icon: Icon(Icons.mic, size: 20))
                : RadiatingActionButton(
                    icon: Icon(Icons.send, size: 16),
                    color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  IconButton _iconButton({required IconData icon}) {
    return IconButton(
      onPressed: () {},
      padding: EdgeInsets.all(4),
      iconSize: 15,
      splashRadius: 12,
      constraints: BoxConstraints(maxHeight: 48, maxWidth: 25),
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }

  Visibility _iconButtonVisibility({required IconData icon}) {
    return Visibility(
        child: _iconButton(icon: icon),
        visible: textEditingController.text.isEmpty ? true : false,
        maintainState: false,
        maintainSize: false);
  }
}
