import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../../../../core/common_widgets/radiating_action_button.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/pick_files_bloc.dart/pick_files_bloc.dart';
import '../bloc/pick_files_bloc.dart/pick_files_event.dart';
import '../bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'send_image_sheet.dart';

class SendMessageBar extends StatefulWidget {
  final String receiverId;
  final List<String> attachmentPaths;

  const SendMessageBar(
      {required this.receiverId, required this.attachmentPaths});
  @override
  State<SendMessageBar> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  late TextEditingController _textEditingController;
  late List<Attachment> _attachments;

  @override
  void initState() {
    _attachments = [];
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
                            fontSize: 14, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8),
                            border: InputBorder.none,
                            hintText: "${L10n.of(context).typeSomething}...",
                            contentPadding: EdgeInsets.all(0))),
                  ),
                  Offstage(
                    offstage: _textEditingController.text.isNotEmpty,
                    child: _iconButton(
                        icon: FontAwesomeIcons.image,
                        onPressed: () async {
                          Provider.of<PickFilesBloc>(context, listen: true)
                              .add(OnSelectMultipleImageEvent());
                          _showBottomSheet(widget.receiverId);
                        }),
                  ),
                  SizedBox(width: 10),
                  _textEditingController.text.isEmpty
                      ? RadiatingActionButton(
                          icon: Icon(Icons.mic, size: 20),
                          onPressed: () {},
                        )
                      : RadiatingActionButton(
                          onPressed: () {
                            Provider.of<SendMessageBloc>(context, listen: false)
                                .add(SendMessageEvent(
                                    text: _textEditingController.text,
                                    receiverId: widget.receiverId,
                                    attachments: _attachments));
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

  PersistentBottomSheetController<dynamic> _showBottomSheet(String receiverId) {
    return Scaffold.of(context).showBottomSheet(
      (context) => SendImageSheet(receiverId: receiverId),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
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
}
