import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/injector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/message.dart';

abstract class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({required this.message}) : super();
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
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: (TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer)),
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
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            elevation: 0.0,
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(20),
            )),
          ),
        ),
      ),
    );
  }
}

class SentMessageBubble extends MessageBubble {
  SentMessageBubble({required Message message}) : super(message: message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onLongPress: () {},
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Card(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: (TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        sLocator.get<TimeFormat>().Hm(message.timeStamp),
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(160),
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        message.isRead
                            ? FontAwesomeIcons.checkDouble
                            : FontAwesomeIcons.check,
                        size: 10,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(160),
                      ),
                    ],
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
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: _borderRadius()),
          ),
        ),
      ),
    );
  }

  BorderRadius _borderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(24),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(20),
    );
  }
}
