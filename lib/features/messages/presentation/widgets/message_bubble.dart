import 'package:chatcalling/features/messages/presentation/bloc/send_message_bloc.dart/send_message_bloc.dart';

import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../../../../core/helpers/time.dart';
import '../../../../core/common_widgets/image_gallery.dart';
import '../../../../injector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../domain/entities/message.dart';

abstract class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({required this.message});
}

class ReceivedMessageBubble extends MessageBubble {
  ReceivedMessageBubble({required Message message}) : super(message: message);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: InkWell(
          onLongPress: () {},
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Card(
            elevation: 0.0,
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
              bottomLeft: Radius.circular(10),
            )),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.attachments.length > 0
                      ? MessageImage(attachments: message.attachments)
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Offstage(
                          offstage: message.text.isEmpty,
                          child: Text(
                            message.text,
                            style: (TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer)),
                          ),
                        ),
                        Text(
                          sLocator.get<TimeFormat>().Hm(message.timeStamp),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SentMessageBubble extends MessageBubble {
  final MessageSentStatus sentStatus;
  SentMessageBubble({required Message message, required this.sentStatus})
      : super(message: message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Offstage(
                offstage: sentStatus != MessageSentStatus.sending,
                child: SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    )),
              ),
              Offstage(
                  offstage: sentStatus != MessageSentStatus.failed,
                  child: InkWell(
                    onTap: () {
                      context.read<SendMessageBloc>().add(
                            SendMessageEvent(
                                text: message.text,
                                receiverId: message.receiverId,
                                attachments: message.attachments),
                          );
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 22,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )),
            ],
          ),
          InkWell(
            onLongPress: () {},
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: _borderRadius()),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    message.attachments.length > 0
                        ? MessageImage(attachments: message.attachments)
                        : SizedBox(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Offstage(
                            offstage: message.text.isEmpty,
                            child: Text(
                              message.text,
                              style: (TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                            ),
                          ),
                          _sentDetail(context),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    stops: [0.1, 0.9],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: _borderRadius(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _sentDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 8),
        Text(
          sLocator.get<TimeFormat>().Hm(message.timeStamp),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary.withAlpha(160),
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
        SizedBox(width: 8),
        Icon(
          sentStatus != MessageSentStatus.sent
              ? FontAwesomeIcons.clock
              : message.isRead
                  ? FontAwesomeIcons.checkDouble
                  : FontAwesomeIcons.check,
          size: 10,
          color: Theme.of(context).colorScheme.onPrimary.withAlpha(160),
        ),
      ],
    );
  }

  BorderRadius _borderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(14),
      bottomLeft: Radius.circular(14),
      bottomRight: Radius.circular(10),
    );
  }
}

class MessageImage extends StatefulWidget {
  const MessageImage({Key? key, required this.attachments}) : super(key: key);

  final List<Attachment> attachments;

  @override
  State<MessageImage> createState() => _MessageImageState();
}

class _MessageImageState extends State<MessageImage> {
  @override
  Widget build(BuildContext context) {
    final double _imageHeight = MediaQuery.of(context).size.width * 0.6;
    final double _imageWidth = MediaQuery.of(context).size.width * 0.7;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: ListView.builder(
              itemCount: widget.attachments.length > 1 ? 2 : 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageGallery(
                        galleryItems: widget.attachments,
                        initialPage: i,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Container(
                          height: _imageHeight,
                          width: _imageWidth,
                          constraints: BoxConstraints(maxHeight: 320),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.attachments[i].url,
                                ),
                                fit: BoxFit.cover),
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: widget.attachments.length < 3 || i != 1,
                        child: Container(
                          height: _imageHeight,
                          width: _imageWidth,
                          constraints: BoxConstraints(maxHeight: 320),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              "+${widget.attachments.length - 1}",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
