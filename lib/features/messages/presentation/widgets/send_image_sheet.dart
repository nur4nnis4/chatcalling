import '../../../../core/common_features/attachment/presentations/bloc/attachments_bloc.dart';
import '../../../../core/common_widgets/image_gallery.dart';
import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/common_widgets/radiating_action_button.dart';
import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../bloc/send_message_bloc.dart/send_message_bloc.dart';
import '../../../../l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendImageSheet extends StatelessWidget {
  final String receiverId;
  final List<Attachment> pickedImageList;

  const SendImageSheet(
      {Key? key, required this.receiverId, required this.pickedImageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Column(children: [
        IconButton(
          onPressed: () {
            context.read<AttachmentsBloc>().add(ResetAttachmentEvent());
            Navigator.pop(context);
          },
          splashRadius: 8,
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: pickedImageList.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageGallery(
                          galleryItems: pickedImageList, initialPage: i),
                    ),
                  ),
                  child: ImagePreview(
                    imageUrl: pickedImageList[i].url,
                  ),
                );
              },
            ),
          ),
        ),
        SendImageBar(pickedImageList: pickedImageList, receiverId: receiverId),
      ]),
    );
  }
}

class SendImageBar extends StatefulWidget {
  final List<Attachment> pickedImageList;
  final String receiverId;

  const SendImageBar({required this.pickedImageList, required this.receiverId});

  @override
  State<SendImageBar> createState() => _SendImageBarState();
}

class _SendImageBarState extends State<SendImageBar> {
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
    return AnimatedBuilder(
        animation: _textEditingController,
        builder: (context, child) {
          return BottomAppBar(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(4),
                    iconSize: 18,
                    splashRadius: 14,
                    constraints: BoxConstraints(maxHeight: 48, maxWidth: 25),
                    icon: Icon(
                      FontAwesomeIcons.faceSmile,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
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
                            hintText: "${L10n.of(context).addCaption}...",
                            contentPadding: EdgeInsets.all(0))),
                  ),
                  SizedBox(width: 10),
                  RadiatingActionButton(
                      heroTag: 'sendImageRAB',
                      onPressed: () {
                        context.read<SendMessageBloc>().add(
                              SendMessageEvent(
                                  text: _textEditingController.text,
                                  receiverId: widget.receiverId,
                                  attachments: widget.pickedImageList),
                            );
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.send, size: 16),
                      color: Theme.of(context).colorScheme.primary)
                ],
              ),
            ),
          );
        });
  }
}
