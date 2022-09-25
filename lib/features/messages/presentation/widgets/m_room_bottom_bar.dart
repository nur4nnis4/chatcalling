import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/radiating_action_button.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/message_list_bloc.dart/message_list_bloc.dart';

class MRoomBottomBar extends StatefulWidget {
  final String receiverId;

  const MRoomBottomBar({required this.receiverId});
  @override
  State<MRoomBottomBar> createState() => _MRoomBottomBarState();
}

class _MRoomBottomBarState extends State<MRoomBottomBar> {
  late TextEditingController _textEditingController;
  late String _attachmentPath;

  @override
  void initState() {
    _attachmentPath = '';
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: AnimatedBuilder(
            animation: _textEditingController,
            builder: (_, __) {
              return Row(
                children: [
                  _iconButton(
                      icon: FontAwesomeIcons.faceSmile, onPressed: () {}),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        controller: _textEditingController,
                        maxLines: 6,
                        minLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8),
                            border: InputBorder.none,
                            hintText: "${L10n.of(context).typeSomething}...",
                            contentPadding: EdgeInsets.all(0))),
                  ),
                  _iconButtonVisiblity(
                      icon: FontAwesomeIcons.image, onPressed: () {}),
                  // _iconButtonVisiblity(
                  //     icon: FontAwesomeIcons.paperclip, onPressed: () {}),
                  SizedBox(width: 10),
                  _textEditingController.text.isEmpty
                      ? RadiatingActionButton(
                          icon: Icon(Icons.mic, size: 20),
                          onPressed: () {},
                        )
                      : RadiatingActionButton(
                          onPressed: () {
                            Provider.of<MessageListBloc>(context, listen: false)
                                .add(SendMessagesEvent(
                                    text: _textEditingController.text,
                                    receiverId: widget.receiverId,
                                    attachmentPath: _attachmentPath));
                            _textEditingController.clear();
                          },
                          icon: Icon(Icons.send, size: 16),
                          color: Theme.of(context).colorScheme.primary),
                ],
              );
            }),
      ),
    );
  }

  IconButton _iconButton(
      {required IconData icon, required Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(4),
      iconSize: 18,
      splashRadius: 14,
      constraints: BoxConstraints(maxHeight: 48, maxWidth: 25),
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }

  Offstage _iconButtonVisiblity(
      {required IconData icon, required Function() onPressed}) {
    return Offstage(
        offstage: _textEditingController.text.isNotEmpty,
        child: _iconButton(icon: icon, onPressed: onPressed));
  }
}
