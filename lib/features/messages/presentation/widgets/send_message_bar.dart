import '../../../../core/common_features/attachment/presentations/bloc/pick_attachments_bloc.dart';
import '../../../../core/common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/common_widgets/radiating_action_button.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/send_message_bloc.dart/send_message_bloc.dart';
import 'send_image_sheet.dart';

class SendMessageBar extends StatefulWidget {
  final String receiverId;

  const SendMessageBar({required this.receiverId});
  @override
  State<SendMessageBar> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
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
    return BlocListener<PickAttachmentsBloc, PickAttachmentsState>(
      listener: (_, state) {
        if (state is PickAttachmentsError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Oops! Something went wrong.'),
            duration: Duration(seconds: 1),
          ));
        } else if (state is MultipleImagesLoaded) {
          Scaffold.of(context).showBottomSheet((_) => SendImageSheet(
              receiverId: widget.receiverId,
              pickedImageList: state.attachments));
        }
      },
      child: BottomAppBar(
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
                          icon: FontAwesomeIcons.paperclip,
                          onPressed: () {
                            _showBottomSheet();
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
                              Provider.of<SendMessageBloc>(context,
                                      listen: false)
                                  .add(SendMessageEvent(
                                      text: _textEditingController.text,
                                      receiverId: widget.receiverId,
                                      attachments: []));
                              _textEditingController.clear();
                            },
                            icon: Icon(Icons.send, size: 16),
                            color: Theme.of(context).colorScheme.primary),
                  ],
                );
              }),
        ),
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

  PersistentBottomSheetController<dynamic> _showBottomSheet() {
    return Scaffold.of(context).showBottomSheet(
      (_) => Padding(
        padding: EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Wrap(spacing: 20, alignment: WrapAlignment.center, children: [
            RoundedIconButton(
              icon: FontAwesomeIcons.image,
              onTap: () {
                Navigator.pop(context);
                context
                    .read<PickAttachmentsBloc>()
                    .add(AttachMultipleImagesEvent());
              },
            ),
            RoundedIconButton(
              icon: FontAwesomeIcons.camera,
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                Navigator.pop(context);
                context.read<PickAttachmentsBloc>().add(TakeCameraImageEvent());
              },
            ),
            RoundedIconButton(
              icon: FontAwesomeIcons.video,
              onTap: () {
                Navigator.pop(context);
                context.read<PickAttachmentsBloc>().add(AttachVideoEvent());
              },
            ),
            RoundedIconButton(
              icon: FontAwesomeIcons.recordVinyl,
              color: Theme.of(context).colorScheme.secondary,
              onTap: () => context
                  .read<PickAttachmentsBloc>()
                  .add(AttachMultipleImagesEvent()),
            ),
          ]),
        ),
      ),
      elevation: 2,
      constraints: BoxConstraints(
          minHeight: kToolbarHeight * 2, minWidth: double.infinity),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
